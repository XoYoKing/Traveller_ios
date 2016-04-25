
//  CitiesViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "CitiesViewController.h"
#import "TravellerConstants.h"
#import "CitiesCollectionViewCell.h"
#import "AddPostViewController.h"
#import "WishToVisitViewController.h"
@interface CitiesViewController ()

@end

@implementation CitiesViewController

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
    self.title=@"Cities";
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesCollectionViewCell *cell=[citiesCollectionView dequeueReusableCellWithReuseIdentifier:@"CitiesCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.frame = [cell bounds];
    cell.placesButton.tag=indexPath.row;
    cell.wishButton.tag=indexPath.row;
    
    [cell.wishButton addTarget:self action:@selector(openWishedToForm:) forControlEvents:UIControlEventTouchUpInside];
    [cell.placesButton addTarget:self action:@selector(openPostForm:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary * dataDict =[globalArrayToShow objectAtIndex:indexPath.row];
    
    NSString * city =[dataDict valueForKey:@"city"];
    NSString * country =[dataDict valueForKey:@"country"];
    NSString * state =[dataDict valueForKey:@"state"];
    
    if (![city isKindOfClass:[NSNull class]]&&![state isKindOfClass:[NSNull class]]) {
        
        if (![country isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:state]) {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city,country];
            }else {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ , %@ ",city , state,country];
            }
        }else {
            if ([city isEqualToString:state]) {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.cityNameLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city , state];
            }
        }
    }else{
        cell.cityNameLbl.text =@"City Name Not Available Now";
    }
    
    //Checked for post Image
    NSString * urlStringForImage =[dataDict valueForKey:@"image"];
    if (![urlStringForImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
        [cell.cityImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }

    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPAD) {
         return CGSizeMake(self.view.frame.size.width/2-10, 340);
    }else{
         return CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.width/2+140);
    }

}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict =[globalArrayToShow objectAtIndex:indexPath.row];
    NSString * cityid=[dict valueForKey:@"id"];
    NSString * name=[dict valueForKey:@"city"];
    NSString * image=[dict valueForKey:@"image"];
    [self openLocationFeedView:cityid :name :image];
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
 //   cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}
-(void)openPostForm:(UIButton *)btn{
    AddPostViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddPostViewController"];
    vc.selectedCityDict=[[NSDictionary alloc]initWithDictionary:[citiesArray objectAtIndex:btn.tag]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)openWishedToForm:(UIButton *)btn{
    WishToVisitViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"WishToVisitViewController"];
    vc.selectedCityDict=[citiesArray objectAtIndex:btn.tag];
    [self.navigationController pushViewController:vc animated:YES];
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
    [notificationButton addShaddow];
    [self.view addSubview:notificationButton];
    [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCitiesData{
  
        NSString * userID =[UserData getUserID];
        NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_CITIES,userID,citiesPage];
        NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
        [citiesArray addObjectsFromArray:[dict valueForKey:@"data"]];
    globalArrayToShow = citiesArray;
        [self performSelectorOnMainThread:@selector(reloadCollectionView) withObject:nil waitUntilDone:YES];
}
    
    -(void)getCitiesDataPaging{
        NSString * userID =[UserData getUserID];
        NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_CITIES,userID,citiesPage];
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
    [citiesCollectionView reloadData];
    [self.view hideLoader];
    if (citiesArray.count==0) {
        [self.view makeToast:@"No Cities Available Right Now" duration:toastDuration position:toastPositionBottomUp];
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city CONTAINS[cd] %@", textField.text];
        globalArrayToShow = [[citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
         [citiesCollectionView reloadData];
    }else{
        globalArrayToShow=citiesArray;
        [citiesCollectionView reloadData];
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
        [citiesCollectionView reloadData];
        textField.text=@"";
        textField.text=searchStr;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city CONTAINS[cd] %@", searchStr];
        globalArrayToShow = [[citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
        [citiesCollectionView reloadData];
    }
    return YES;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    globalArrayToShow=citiesArray;
    [citiesCollectionView reloadData];
    textField.text=@"";
    return YES;
}

- (IBAction)searchClick:(id)sender {
    if ([searchTF.text isEqualToString:@""]) {
        [self.view makeToast:@"Please add some text in search textfield" duration:toastDuration position:toastPositionBottomUp];
    }
}
#pragma mark====================Open Location Feeds=============================
-(void)openLocationFeedView:(NSString *)locationId :(NSString *)locName :(NSString *)photoUrl{
    LocationFeedViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LocationFeedViewController"];
    vc.cityId=locationId;
    vc.name=locName;
    vc.imageUrl=photoUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
