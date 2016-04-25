//
//  InviteToJoinViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 15/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "InviteToJoinViewController.h"

@interface InviteToJoinViewController ()

@end

@implementation InviteToJoinViewController

-(void)viewDidAppear:(BOOL)animated{
    if (badgeView==nil) {
        [self addNotificationView];
    }
    if (citiesArray.count==0||citiesArray==nil) {
        [self.view showLoader];
        [self performSelectorInBackground:@selector(getCitiesData) withObject:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.title=@"Search";
    citiesArray=[NSMutableArray new];
    citiesPage=1;
    citiesPagingBoolean=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationCount:) name:throwNotificationStatus object:nil];
    [self setUpView];
    [self setUpNavigationBar];
    
    wishToTableView.estimatedRowHeight=130;
    wishToTableView.rowHeight=UITableViewAutomaticDimension;
    [wishToTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    wishToTableView.separatorColor = [UIColor lightGrayColor];
    wishToTableView.tableFooterView=[UIView new];
}

-(void)setUpView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnView)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    //    [self.view addGestureRecognizer:tap];
    
    searchBtn.titleLabel.font =[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    [searchBtn setTitle:[NSString stringWithUTF8String:ICOMOON_SEARCH] forState:UIControlStateNormal];
    searchTF.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    
}
-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=[UIColor whiteColor];
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)tappedOnView{
    [self.view endEditing:YES];
}

-(void)updateNotificationCount:(NSNotification *)notification{
    NSDictionary * dict =notification.object;
    int count = [[dict valueForKey:@"tip_count"] intValue];
    badgeView.badgeValue = count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return globalArrayToShow.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
    [wishToTableView registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
    FollowingTableViewCell *cell =  [wishToTableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
    
    NSDictionary * dataDict =[globalArrayToShow objectAtIndex:indexPath.row];
    NSString * city =[dataDict valueForKey:@"city"];
    NSString * name =[dataDict valueForKey:@"name"];
    
    if (![city isKindOfClass:[NSNull class]]) {
        if (![city isEqualToString:@""]) {
            cell.addressLbl.text =[NSString stringWithFormat:@" %@ ",city];
        }
    }else{
        cell.addressLbl.text =@"City Name Not Available Now";
    }
    
    if (![name isKindOfClass:[NSNull class]]) {
        cell.nameLbl.text=name;
    }else {
        cell.nameLbl.text=@"Country Name Not Available Now";
    }
    
    //Checked for post Image
    NSString * urlStringForImage =[dataDict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
    
    // For Paging Mechanism
    if (indexPath.row==citiesArray.count -3) {
        if (citiesPagingBoolean==YES) {
            citiesPage++;
            [self performSelectorInBackground:@selector(getCitiesDataPaging) withObject:nil];
        }
    }
    
    int  showFollow  = [[dataDict valueForKey:@"follow"]intValue];
    if (showFollow ==1) {
        [cell.followButton setTitle:@"Invite" forState:UIControlStateNormal];
        [cell.followButton setBackgroundColor:userShouldNOTDOButoonColor];
    }else{
        [cell.followButton setTitle:@"UnInvite" forState:UIControlStateNormal];
        [cell.followButton setBackgroundColor:userShouldDOButoonColor];
    }
    cell.followButton.tag=indexPath.row;
    [cell.followButton addTarget:self action:@selector(inviteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

-(void)addNotificationView{
    UIButton *  notificationButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    notificationButton.frame = CGRectMake(self.view.frame.size.width-65,self.view.frame.size.height-65,50,50);
    notificationButton.titleLabel.font =[UIFont fontWithName:fontIcomoon size:25];
    notificationButton.titleLabel.textColor=[UIColor whiteColor];
    notificationButton.backgroundColor=[UIColor blackColor];
    notificationButton.layer.cornerRadius=25;
    [notificationButton setTitle:[NSString stringWithUTF8String:ICOMOON_BELL] forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(openNotificationView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBarHidden=NO;
    badgeView = [GIBadgeView new];
    [notificationButton addSubview:badgeView];
    badgeView.badgeValue = [UserData getNotificationCount];
    [self addShaddowToView:notificationButton];
    [self.view addSubview:notificationButton];
    [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getCitiesData{
    
    NSString * cityId=[_selectedCityDict valueForKey:@"id"];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&userId=%@&page=%d&cityId=%@",URL_CONST,ACTION_GET_VISITED_CITY_PEOPLE,[UserData getUserID],citiesPage,cityId];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [citiesArray addObjectsFromArray:[[dict valueForKey:@"data"] valueForKey:@"memberData"]];
    globalArrayToShow = citiesArray;
    [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
}

-(void)getCitiesDataPaging{
    
    NSString * cityId=[_selectedCityDict valueForKey:@"id"];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&userId=%@&page=%d&cityId=%@",URL_CONST,ACTION_GET_VISITED_CITY_PEOPLE,[UserData getUserID],citiesPage,cityId];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[[dict valueForKey:@"data"]valueForKey:@"memberData"];
    if (data.count==0) {
        citiesPagingBoolean=NO;
    }else{
        [citiesArray addObjectsFromArray:[dict valueForKey:@"data"]];
        [globalArrayToShow addObjectsFromArray:[dict valueForKey:@"data"]];
        citiesPagingBoolean=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
}

-(void)reloadCollectionView{
    [wishToTableView reloadData];
    [self.view hideLoader];
    if (citiesArray.count==0) {
        [self.view makeToast:@"No Peoples Available Right Now" duration:toastDuration position:toastPositionBottomUp];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]||[touch.view isKindOfClass:[UICollectionViewCell class]]) {
        // we touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES;
}
#pragma mark - TextField Delegates

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name  CONTAINS[cd] %@", textField.text];
        globalArrayToShow = [[citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
        [wishToTableView reloadData];
    }else{
        globalArrayToShow=citiesArray;
        [wishToTableView reloadData];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([searchStr isEqualToString:@""]) {
        globalArrayToShow=citiesArray;
        [wishToTableView reloadData];
        textField.text=@"";
        textField.text=searchStr;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchStr];
        globalArrayToShow = [[citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
        [wishToTableView reloadData];
    }
    return YES;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    globalArrayToShow=citiesArray;
    [wishToTableView reloadData];
    textField.text=@"";
    return YES;
}

- (IBAction)searchClick:(id)sender {
    if ([searchTF.text isEqualToString:@""]) {
        [self.view makeToast:@"Please add some text in search textfield" duration:toastDuration position:toastPositionBottomUp];
    }
}

-(void)inviteClick:(UIButton*)btn{
    int index = (int)btn.tag;
    NSIndexPath * ip =[NSIndexPath indexPathForRow:index inSection:0];
    FollowingTableViewCell *cell =  [wishToTableView cellForRowAtIndexPath:ip];
    NSDictionary * dataDict =[globalArrayToShow objectAtIndex:index];
    publicID = [dataDict valueForKey:@"id"];
    int  showFollow  = [[dataDict valueForKey:@"follow"]intValue];
    if (showFollow ==1) {
        [cell.followButton setTitle:@"UnInvite" forState:UIControlStateNormal];
        [cell.followButton setBackgroundColor:userShouldNOTDOButoonColor];
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dataDict];
        [newDict setObject:@"0" forKey:@"follow"];
        [globalArrayToShow replaceObjectAtIndex:index withObject:newDict];
        [self.view makeToast:@"You univited the person"duration:toastDuration position:toastPositionBottomUp];
        
    }else{
        [cell.followButton setTitle:@"Invite" forState:UIControlStateNormal];
        [cell.followButton setBackgroundColor:userShouldDOButoonColor];
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dataDict];
        [newDict setObject:@"1" forKey:@"follow"];
        [globalArrayToShow replaceObjectAtIndex:index withObject:newDict];
        [self.view makeToast:@"You invited the person"duration:toastDuration position:toastPositionBottomUp];
    }
    [self performSelectorInBackground:@selector(inviteWebservice) withObject:nil];
}

-(void)inviteWebservice{
    NSString * ids =[NSString stringWithFormat:@"%@",publicID];
    NSString * cityId=[_selectedCityDict valueForKey:@"id"];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&userId=%@&publicId=%@&cityId=%@",URL_CONST,ACTION_INVITE,[UserData getUserID],ids,cityId];
     [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    }

@end
