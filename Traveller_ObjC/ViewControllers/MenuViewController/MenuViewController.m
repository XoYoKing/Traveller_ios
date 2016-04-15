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
  
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationCount:) name:throwNotificationStatus object:nil];
}

-(void)updateNotificationCount:(NSNotification *)notification{
     NSDictionary * dict =notification.object;
    int count = [[dict valueForKey:@"tip_count"] intValue];
    badgeView.badgeValue = count;
}

-(void)viewWillAppear:(BOOL)animated{
      [self performSelectorInBackground:@selector(getAllNotifications) withObject:nil];
}

-(void)setUpView{
    [menuTableView reloadData];
    tableHeightConstraints.constant=menuTableView.contentSize.height;
    [menuTableView layoutIfNeeded];
    [self.view layoutIfNeeded];
    imageViewOfUser.layer.cornerRadius=50;
    imageViewOfUser.layer.borderWidth=2;
    imageViewOfUser.layer.borderColor=[UIColor whiteColor].CGColor;
    imageViewOfUser.clipsToBounds=YES;
    [imageViewOfUser addShaddow];
    notificationView.layer.cornerRadius=20;
     badgeView = [GIBadgeView new];
    [notificationView addSubview:badgeView];
    badgeView.badgeValue = [UserData getNotificationCount];
    
    UILabel * lbl =[[UILabel alloc]init];
    lbl.frame=notificationView.bounds;
    lbl.textColor=[UIColor whiteColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    nameOfUser.font =[UIFont fontWithName:font_bold size:font_size_bold];
    addressOfUser.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    
    
    NSURL * profileUrl =[NSURL URLWithString:[UserData getUserImageUrl]];
    if (profileUrl) {
        [imageViewOfUser sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }

    nameOfUser.text=[UserData getUserName];
    addressOfUser.text=[UserData getUserCity];
    
    
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
        [self opemTravellingToMenu];
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
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
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

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

-(void)getAllNotifications{
    NSString * userID =[UserData getUserID];
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&userId=%@",URL_CONST,ACTION_GET_NOTIFICATION,userID];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            int totalCount =[[dict valueForKey:@"tip_count"]intValue];
            [UserData setNotificationCount:totalCount];
            
            NSArray * invitation =[[NSArray alloc]initWithArray:[dict valueForKey:@"invitation"]];
            NSArray * ask_for_tip =[[NSArray alloc]initWithArray:[dict valueForKey:@"ask_for_tip"]];
            NSArray * follow =[[NSArray alloc]initWithArray:[dict valueForKey:@"follow"]];
            NSArray * message =[[NSArray alloc]initWithArray:[dict valueForKey:@"message"]];
            
            NSDictionary * dict =@{
                                       @"invitation":invitation,
                                       @"ask_for_tip":ask_for_tip,
                                       @"follow":follow,
                                       @"message":message
                                   };
            [UserData setNotificationDict:dict];
            NSDictionary * not_Dict=@{@"tip_count":[NSString stringWithFormat:@"%d",totalCount]};
            [[NSNotificationCenter defaultCenter] postNotificationName:throwNotificationStatus object:not_Dict];
        }
    }else{
        
    }

}

@end
