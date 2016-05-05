//
//  SearchViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SearchViewController.h"
#import "ViewProfileController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
-(void)viewDidAppear:(BOOL)animated{
    if (badgeView==nil) {
        [self addNotificationView];
    }
if (citiesArray.count==0||citiesArray==nil) {
    [self.view showLoader];
    [self performSelectorInBackground:@selector(getCitiesData) withObject:nil];
}
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Search";
    citiesArray=[NSMutableArray new];
    citiesPage=1;
    citiesPagingBoolean=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationCount:) name:throwNotificationStatus object:nil];
    [self setUpView];
    [self setUpNavigationBar];
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
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=back_btn_Color;
    //  [btnClose setTitle:[FontIcon iconString:ICON_CANCEL] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    //self.navigationItem.leftBarButtonItem = leftbarButton;
}

-(void)backClick{
    AppDelegate *d = [[UIApplication sharedApplication] delegate];
    [d.drawerView showLeftPanelAnimated:YES ];
}



-(void)tappedOnView{
    [self.view endEditing:YES];
}

-(void)updateNotificationCount:(NSNotification *)notification{
    NSDictionary * dict =notification.object;
    int count = [[dict valueForKey:@"tip_count"] intValue];
    badgeView.badgeValue = count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return globalArrayToShow.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell=[searchCollectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.frame = [cell bounds];
    NSDictionary * dataDict =[globalArrayToShow objectAtIndex:indexPath.row];

    NSString * city =[dataDict valueForKey:@"city"];
    NSString * country =[dataDict valueForKey:@"country"];
    NSString * name =[dataDict valueForKey:@"name"];
    
    if (![city isKindOfClass:[NSNull class]]&&![country isKindOfClass:[NSNull class]]) {
        if ([city isEqualToString:country]) {
            if(![city isEqualToString:@""]){
                  cell.adressLbl.text =[NSString stringWithFormat:@" %@ ",city];
            }else{
                cell.adressLbl.text =@"Not Available Now";
            }
          
        }else {
            cell.adressLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city , country];
        }
    }else{
        cell.adressLbl.text =@"Not Available Now";
    }
    
    if (![name isKindOfClass:[NSNull class]]) {
        if([name isEqualToString:@""]){
             cell.userNameLbl.text=@"Not Available Now";
        }else {
        cell.userNameLbl.text=name;
        }
    }else {
        cell.userNameLbl.text=@"Not Available Now";
    }
    
    //Checked for post Image
    NSString * urlStringForImage =[dataDict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]||[urlStringForImage isEqualToString:@""]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.imageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
    cell.imageView.layer.cornerRadius=42;
    cell.imageView.clipsToBounds=YES;
    
   cell.followLogoLbl.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    if ([[dataDict valueForKey:@"follow" ] intValue] == 0){
        cell.followNameLbl.text=@"Follow";
        cell.followLogoLbl.text=   [NSString stringWithUTF8String:ICOMOON_USER_ICONPlus];
        cell.followNameLbl.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
        cell.followBackView.backgroundColor=navigation_background_Color;
    }else{
        cell.followNameLbl.text=@"Following";
        cell.followLogoLbl.text=  [NSString stringWithUTF8String:ICOMOON_USERICON_minus];
        cell.followNameLbl.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
        cell.followBackView.backgroundColor=Like_Color;
    }
    
    if ([[dataDict valueForKey:@"mid"] isEqualToString: [UserData getUserID]]) {
        cell.followNameLbl.hidden=YES;
        cell.followLogoLbl.hidden=YES;
        cell.followNameLbl.hidden=YES;
        cell.followBackView.hidden=YES;
    }else{
        cell.followNameLbl.hidden=YES;
        cell.followLogoLbl.hidden=YES;
        cell.followNameLbl.hidden=YES;
        cell.followBackView.hidden=YES;
    }
    
    
    cell.followBtn.tag=indexPath.row;
    [cell.followBtn addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];



    // For Paging Mechanism
    if (indexPath.row==citiesArray.count -3) {
        if (citiesPagingBoolean==YES) {
            citiesPage++;
            [self performSelectorInBackground:@selector(getCitiesDataPaging) withObject:nil];
        }
    }

    
    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(iPhone4s||iPhone5or5s){
         return CGSizeMake(self.view.frame.size.width/2  , 160);
    }else{
        if (iPAD) {
             return CGSizeMake(self.view.frame.size.width/4  , 200);
        }else{
           return CGSizeMake(self.view.frame.size.width/2  , 200);
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict =[globalArrayToShow objectAtIndex:indexPath.row];
    NSString * uid=[dict valueForKey:@"id"];
    NSString * name=[dict valueForKey:@"name"];
    NSString * image =[dict valueForKey:@"image"];
    [self openUserProfile:uid :name :image];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;

    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
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
   // [self.view addSubview:notificationButton];
   // [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getCitiesData{

    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&type=user&page=%d&userId=%@",URL_CONST,ACTION_SEARCH_USER,citiesPage,[UserData getUserID]];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [citiesArray addObjectsFromArray:[dict valueForKey:@"data"]];
    globalArrayToShow = citiesArray;
    [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
}

-(void)getCitiesDataPaging{

    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&&type=user&page=%d&userId=%@",URL_CONST,ACTION_SEARCH_USER,citiesPage,[UserData getUserID]];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[dict valueForKey:@"data"];
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
    [searchCollectionView reloadData];
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
        [searchCollectionView reloadData];
    }else{
        globalArrayToShow=citiesArray;
        [searchCollectionView reloadData];
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
        [searchCollectionView reloadData];
        textField.text=@"";
        textField.text=searchStr;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchStr];
        globalArrayToShow = [[citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
        [searchCollectionView reloadData];
    }
    return YES;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    globalArrayToShow=citiesArray;
    [searchCollectionView reloadData];
    textField.text=@"";
    return YES;
}
#pragma mark====================Open User Profile=============================
-(void)openUserProfile:(NSString * )userId :(NSString *)userName :(NSString *)urlStringForProfileImage {
    if (![userId isEqualToString:[UserData getUserID]]&& userId!=nil) {
        ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
        vc.userId=userId;
        vc.name=userName;
        vc.imageUrl=urlStringForProfileImage;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (IBAction)searchClick:(id)sender {
    if ([searchTF.text isEqualToString:@""]) {
        [self.view makeToast:@"Please add some text in search textfield" duration:toastDuration position:toastPositionBottomUp];
    }
}

#pragma mark ====================FollowMechanism=============================
-(void)followButtonClick:(UIButton *)btn{
    selectedIndex =(int)btn.tag;
    [self.view showLoader];
    [self performSelectorInBackground:@selector(followWebservice) withObject:nil];
}
-(void)followWebservice{
    NSDictionary * dataDict ;
    dataDict =[globalArrayToShow objectAtIndex:selectedIndex];
    NSString * publicId =[dataDict valueForKey:@"id"];
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@",URL_CONST,ACTION_ADD_FOLLOWER, userID,publicId];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [self performSelectorOnMainThread:@selector(reloadTableRow:) withObject:homefeed waitUntilDone:YES];
}

-(void)reloadTableRow:(NSDictionary *)homefeed{
    NSDictionary * dataDict =[globalArrayToShow objectAtIndex:selectedIndex];
    if (homefeed) {
        if ([[homefeed valueForKey:@"message"]isEqualToString:@"you are now following the user"]) {
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"1" forKey:@"follow"];
            [citiesArray replaceObjectAtIndex:selectedIndex withObject:newDict];
            [self.view makeToast:@"You are now following the user"duration:toastDuration position:toastPositionBottomUp];
        }else{
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"0" forKey:@"follow"];
            [citiesArray replaceObjectAtIndex:selectedIndex withObject:newDict];
            [self.view makeToast:@"You are NOT following the user now"duration:toastDuration position:toastPositionBottomUp];
        }
    }
    NSIndexPath * ip =[NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [searchCollectionView reloadItemsAtIndexPaths:@[ip]];
    [self.view hideLoader];
}

@end
