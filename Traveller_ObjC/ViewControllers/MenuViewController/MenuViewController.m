//
//  MenuViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "MenuViewController.h"
#import "TravellerConstants.h"
@interface MenuViewController ()
{
    __weak IBOutlet NSLayoutConstraint *tableHeightConstraints;
    __weak IBOutlet UIImageView *imageViewOfUser;
    __weak IBOutlet UILabel *nameOfUser;
    __weak IBOutlet UILabel *addressOfUser;
    
    NSArray * menuArr;
    AppDelegate *appdelegate;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate =[[UIApplication sharedApplication] delegate];
    menuArr=@[@"Travelline",@"Cities",@"Travelling To",@"Search",@"Settings",@"LogOut"];
      [self setUpView];
}
-(void)setUpView{
    [menuTableView reloadData];
    tableHeightConstraints.constant=menuTableView.contentSize.height;
    [menuTableView layoutIfNeeded];
    [self.view layoutIfNeeded];
    imageViewOfUser.layer.cornerRadius=7;
    imageViewOfUser.layer.borderWidth=2;
    imageViewOfUser.layer.borderColor=[UIColor whiteColor].CGColor;
    [self addShaddowToView:imageViewOfUser];
    notificationView.layer.cornerRadius=20;
     badgeView = [GIBadgeView new];
    [notificationView addSubview:badgeView];
    badgeView.badgeValue = 5;
    
    UILabel * lbl =[[UILabel alloc]init];
    lbl.frame=notificationView.bounds;
    lbl.textColor=[UIColor whiteColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    
    if (iPhone6||iPhone6plus||iPAD) {
        lbl.font=[UIFont fontWithName:fontIcomoon size:23];
    }else{
        lbl.font=[UIFont fontWithName:fontIcomoon size:20];
    }
    
    lbl.text=[NSString stringWithUTF8String:ICOMOON_BELL] ;
    [notificationView addSubview:lbl];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell * cell =[menuTableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    if (iPhone6||iPhone6plus||iPAD) {
        cell.menuImgLbl.font=[UIFont fontWithName:fontIcomoon size:25];
    }else{
        cell.menuImgLbl.font=[UIFont fontWithName:fontIcomoon size:20];
    }

    if (indexPath.row==0) {
       cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_EARTH] ;
    }else if (indexPath.row==1){
      cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_LOCATION] ;
    }else if (indexPath.row==2){
       cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_PLANE] ;
    }else if (indexPath.row==3){
       cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_SEARCH] ;
    }else if (indexPath.row==4){
       cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_SETTING] ;
    }else if (indexPath.row==5){
       cell.menuImgLbl.text=[NSString stringWithUTF8String:ICOMOON_LOGOUT] ;
    }

    
 
    
    cell.menuTitleLbl.text=[menuArr objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
              [self openHomeMenu];
    }else if (indexPath.row==1){
          [self openCitiesMenu];
    }else if (indexPath.row==2){
       // [self opemTravellingToMenu];
         [self openCitiesMenu];
    }else if (indexPath.row==3){
        [self openSearchMenu];
    }else if (indexPath.row==4){
        [self openSettingMenu];
    }else if (indexPath.row==5){
        [self logOutClick];
    }
}

-(void)openUserProfile{
    ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}
-(void)openCitiesMenu{
    CitiesViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CitiesViewController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
   appdelegate.drawerView.centerPanel=nav;
}
-(void)opemTravellingToMenu{
        TravellingToViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TravellingToViewController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}
-(void)openSearchMenu{
    SearchViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}
-(void)openSettingMenu{
     SettingViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}
-(void)logOutClick{
    [UserData setLogOutStatus];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)openHomeMenu{
    HomeViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}

-(IBAction)OpenNotifications:(id)sender{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=YES;
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    appdelegate.drawerView.centerPanel=nav;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup Header ScrollView
//-(void)SetupHeaderScrollView{
//    
//    for (int i=(int) _myScrollView.subviews.count - 1; i>=0; i--)
//        [[_myScrollView.subviews objectAtIndex:i] removeFromSuperview];
//    
//    
//    
//    CGFloat scrollWidth = 0.f;
//    buttonArray=[[NSMutableArray alloc]init];
//    for ( int j=0; j<company_worksites.count; j++)
//    {
//        NSString * name =[[company_worksites objectAtIndex: j]valueForKey:@"location_name"];
//        CGSize size = [name sizeWithAttributes:
//                       @{NSFontAttributeName: [UIFont fontWithName:font_family_Bold size:17]}];
//        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
//        CGFloat strikeWidth = textSize.width;
//        CGRect frame = CGRectMake(scrollWidth, 10,strikeWidth+20, 40);
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTag:j];
//        button.frame = frame;
//        [button setBackgroundColor:[UIColor whiteColor]];
//        button.titleLabel.textColor=[UIColor blackColor];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.titleLabel.textAlignment=NSTextAlignmentCenter;
//        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:name forState:UIControlStateNormal];
//        
//        scrollWidth= scrollWidth+strikeWidth+20;
//        
//        if (j==selectedIndex) {
//            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 5, button.frame.size.width, 5)];
//            bottomBorder.backgroundColor = kAppThemeRedColor;
//            [button addSubview:bottomBorder];
//            if (iPhone6||iPhone6plus) {
//                button.titleLabel.font=[UIFont fontWithName:font_family_Bold size:17];
//            }else {
//                button.titleLabel.font=[UIFont fontWithName:font_family_Bold size:15];
//            }
//        }else {
//            if (iPhone6||iPhone6plus) {
//                button.titleLabel.font=[UIFont fontWithName:font_family_light size:17];
//            }else{
//                button.titleLabel.font=[UIFont fontWithName:font_family_light size:15];
//            }
//        }
//        
//        [buttonArray addObject:button];
//        [_myScrollView addSubview:button];
//        
//    }
//    _myScrollView.contentSize = CGSizeMake(scrollWidth, 50.f);
//    _myScrollView.pagingEnabled = NO;
//}
//
//
//#pragma mark - Header Button Action
//-(void)buttonEvent:(UIButton*)sender
//{
//    NSInteger index= sender.tag;
//    selectedIndex=index;
//    for(int i=0;i<buttonArray.count;i++)
//    {
//        if(i==index)
//        {
//            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, sender.frame.size.height - 5, sender.frame.size.width, 5)];
//            bottomBorder.backgroundColor = kAppThemeRedColor;
//            [sender addSubview:bottomBorder];
//            if (iPhone6||iPhone6plus) {
//                sender.titleLabel.font=[UIFont fontWithName:font_family_Bold size:17];
//            }else{
//                sender.titleLabel.font=[UIFont fontWithName:font_family_Bold size:15];
//            }
//            NSString * worksiteId = [[company_worksites objectAtIndex:index]valueForKey:@"location_id"];
//            event_data=[[NSMutableArray alloc]init];
//            [collectionView reloadData];
//            HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//            [self performSelector:@selector(LoadBookingdashBordWebservices:) withObject:worksiteId afterDelay:0.1];
//            
//        }
//        else{
//            UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
//            if (iPhone6||iPhone6plus) {
//                btn.titleLabel.font=[UIFont fontWithName:font_family_light size:17];
//            }else{
//                btn.titleLabel.font=[UIFont fontWithName:font_family_light size:15];
//            }
//            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height - 5, btn.frame.size.width, 5)];
//            bottomBorder.backgroundColor = [UIColor whiteColor];
//            [btn addSubview:bottomBorder];
//        }
//    }
//    
//    count=[[NSString stringWithFormat:@"%ld",(long)sender.tag]intValue];
//    CGRect frame1 = _myScrollView.frame;
//    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:index];
//    frame1 =bt.frame ;
//    [_myScrollView scrollRectToVisible:frame1 animated:YES];
//}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
