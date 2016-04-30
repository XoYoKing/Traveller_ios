//
//  ViewProfileController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewProfileController.h"
#import "HomeViewController.h"
#import "UIImage+ImageEffects.h"
#import "TravellerConstants.h"
#import "JASidePanelController.h"
#import "ViewProfileController.h"
#import "LocationFeedViewController.h"
#import "LikeViewController.h"
#import "CommentsViewController.h"
@interface ViewProfileController ()<UITableViewDelegate, UITableViewDataSource>
{
}

@end

@implementation ViewProfileController
#pragma mark====================View Controller Life Cycles===============================

-(void)viewDidAppear:(BOOL)animated{
    [RFRateMe showRateAlertAfterTimesOpened:30];
    if (firstTimePageOpen==YES) {
        [self.view showLoader];
        [self performSelectorInBackground:@selector(getHomeFeedData) withObject:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if (firstTimePageOpen==NO) {
        self.navigationController.navigationBarHidden=NO;
        self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
        self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    homeFeedPage=1;
    followerPage=1;
    followingPage=1;
    wishToPage=1;
    visitedCitiesPage=1;
    selectedIndex=0;
    homeFeedData=[NSMutableArray new];
    followerData=[NSMutableArray new];
    followingData=[NSMutableArray new];
    wishToData=[NSMutableArray new];
    visitedCitiesData=[NSMutableArray new];
    firstTimePageOpen=YES;
    homeFeedPageShouldDoPaging=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationCount:) name:throwNotificationStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLikeCell:) name:throwRefreshLike object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCommentCell:) name:throwRefreshComment object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:throwRefreshPage object:nil];
    
}

-(void)refreshView{
    switch (selectedIndex) {
            //=====================1st click ====================
        case 0:
        {
            
            [self performSelectorInBackground:@selector(getHomeFeedData) withObject:nil];
            
        }break;
            //=====================2st click ====================
        case 1:
            
            [self performSelectorInBackground:@selector(getVisitedCitiesData) withObject:nil];
            
            break;
            //=====================3st click ====================
        case 2:
            
            [self performSelectorInBackground:@selector(getWishData) withObject:nil];
            
            break;
            //=====================4st click ====================
        case 3:
            
            [self performSelectorInBackground:@selector(getFollowerData) withObject:nil];
            
            break;
            //=====================5st click ====================
        case 4:
            
            [self performSelectorInBackground:@selector(getFollowListData) withObject:nil];
            break;
        default:
            break;
    }
    
}

-(void)updateNotificationCount:(NSNotification *)notification{
    NSDictionary * dict =notification.object;
    int count = [[dict valueForKey:@"tip_count"] intValue];
    badgeView.badgeValue = count;
}

-(void)refreshLikeCell:(NSNotification *)notification{
    NSIndexPath * ip =[NSIndexPath indexPathForRow:indexForLikeNotification inSection:0];
    
    if (ip!=nil) {
        FeedsTableViewCell *cell = (FeedsTableViewCell *)[self.tableView cellForRowAtIndexPath:ip];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary * dataDict =[homeFeedData objectAtIndex:indexPath.row];
        
        if ([[dataDict valueForKey:@"is_like"]intValue] == 1) {
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"0" forKey:@"is_like"];
            int like =[[dataDict valueForKey:@"total_like"]intValue];
            like--;
            [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_like"];
            [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
            [self.view makeToast:@"You removed your like of the post"duration:toastDuration position:toastPositionBottomUp];
            
        }else{
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"1" forKey:@"is_like"];
            int like =[[dataDict valueForKey:@"total_like"]intValue];
            like++;
            [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_like"];
            [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
            [self.view makeToast:@"You liked the post"duration:toastDuration position:toastPositionBottomUp];
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}


-(void)refreshCommentCell:(NSNotification *)notification{
    NSIndexPath * ip =[NSIndexPath indexPathForRow:indexForCommentNotification inSection:0];
    if (ip!=nil) {
        FeedsTableViewCell *cell = (FeedsTableViewCell *)[self.tableView cellForRowAtIndexPath:ip];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary * dataDict =[homeFeedData objectAtIndex:indexPath.row];
        if ([[dataDict valueForKey:@"is_my"]intValue] == 1) {
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"0" forKey:@"is_my"];
            int like =[[dataDict valueForKey:@"total_comments"]intValue];
            like--;
            [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_comments"];
            [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
        }else{
            NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
            [newDict addEntriesFromDictionary:dataDict];
            [newDict setObject:@"1" forKey:@"is_my"];
            int like =[[dataDict valueForKey:@"total_comments"]intValue];
            like++;
            [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_comments"];
            [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark====================Notification View===============================
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

#pragma mark====================Set Up Home View Dont Do Any Changes Here=============================
#pragma mark===============These are private methods Written By Sagar Shirbhate=============================
-(void)setHomeView{
    
    self.navigationController.navigationBarHidden=NO;
    [self configureNavBar];
    
    _headerHeight = feed_headerHeight;
    _subHeaderHeight = feed_subHeaderHeight;
    _avatarImageSize = feed_avatarImageSize;
    _avatarImageCompressedSize = feed_avatarImageCompressedSize;
    _barIsCollapsed = false;
    _barAnimationComplete = false;
    
    
    self.tableView.estimatedRowHeight=50;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    UIApplication* sharedApplication = [UIApplication sharedApplication];
    CGFloat kStatusBarHeight = sharedApplication.statusBarFrame.size.height;
    CGFloat kNavBarHeight =  self.navigationController.navigationBar.frame.size.height;
    
    _headerSwitchOffset = _headerHeight - /* To compensate  the adjust scroll insets */(kStatusBarHeight + kNavBarHeight)  - kStatusBarHeight - kNavBarHeight;
    
    NSMutableDictionary* views = [NSMutableDictionary new];
    views[@"super"] = self.view;
    
    UITableView* tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO; //autolayout
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.hidden=YES;
    views[@"tableView"] = tableView;
    
    UIImage* bgImage = [UIImage imageNamed:@"Place"];
    _originalBackgroundImage = bgImage;
    
    UIImageView* headerImageView = [[UIImageView alloc] initWithImage:bgImage];
    headerImageView.translatesAutoresizingMaskIntoConstraints = NO; //autolayout
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = true;
    self.imageHeaderView = headerImageView;
    views[@"headerImageView"] = headerImageView;
    
    /* Not using autolayout for this one, because i don't really have control on how the table view is setting up the items.*/
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                                       _headerHeight - /* To compensate  the adjust scroll insets */(kStatusBarHeight + kNavBarHeight) + _subHeaderHeight)];
    //tableHeaderView.backgroundColor = [UIColor purpleColor];
    [tableHeaderView addSubview:headerImageView];
    
    UIView* subHeaderPart = [self createSubHeaderView];// [[UIView alloc] init];
    subHeaderPart.translatesAutoresizingMaskIntoConstraints = NO; //autolayout
    // subHeaderPart.backgroundColor  = [UIColor greenColor];
    [tableHeaderView insertSubview:subHeaderPart belowSubview:headerImageView];
    views[@"subHeaderPart"] = subHeaderPart;
    
    tableView.tableHeaderView = tableHeaderView;
    
    UIImageView* avatarImageView = [self createAvatarImage];
    
    NSURL * profileUrl =[NSURL URLWithString:_imageUrl];
    if (profileUrl) {
        [avatarImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
    }
    
    avatarImageView.translatesAutoresizingMaskIntoConstraints = NO; //autolayout
    views[@"avatarImageView"] = avatarImageView;
    avatarImageView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnUserImage)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [avatarImageView addGestureRecognizer:tap];
    
    [tableHeaderView addSubview:avatarImageView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //Now Let's do the layout
    NSArray* constraints;
    NSLayoutConstraint* constraint;
    NSString* format;
    NSDictionary* metrics = @{
                              @"headerHeight" : [NSNumber numberWithFloat:_headerHeight- /* To compensate  the adjust scroll insets */(kStatusBarHeight + kNavBarHeight) ],
                              @"minHeaderHeight" : [NSNumber numberWithFloat:(kStatusBarHeight + kNavBarHeight)],
                              @"avatarSize" :[NSNumber numberWithFloat:_avatarImageSize],
                              @"avatarCompressedSize" :[NSNumber numberWithFloat:_avatarImageCompressedSize],
                              @"subHeaderHeight" :[NSNumber numberWithFloat:_subHeaderHeight],
                              };
    
    // ===== Table view should take all available space ========
    
    format = @"|-0-[tableView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    format = @"V:|-0-[tableView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    // ===== Header image view should take all available width ========
    
    format = @"|-0-[headerImageView]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [tableHeaderView addConstraints:constraints];
    
    format = @"|-0-[subHeaderPart]-0-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [tableHeaderView addConstraints:constraints];
    
    
    // ===== Header image view should not be smaller than nav bar and stay below navbar ========
    
    format = @"V:[headerImageView(>=minHeaderHeight)]-(subHeaderHeight@750)-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    format = @"V:|-(headerHeight)-[subHeaderPart(subHeaderHeight)]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    // ===== Header image view should stick to top of the 'screen'  ========
    
    NSLayoutConstraint* magicConstraint = [NSLayoutConstraint constraintWithItem:headerImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0];
    [self.view addConstraint: magicConstraint];
    
    // ===== avatar should stick to left with default margin spacing  ========
    format = @"|-[avatarImageView]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    // === avatar is square
    constraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:avatarImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0];
    [self.view addConstraint: constraint];
    
    // ===== avatar size can be between avatarSize and avatarCompressedSize
    format = @"V:[avatarImageView(<=avatarSize@760,>=avatarCompressedSize@800)]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
    [self.view addConstraints:constraints];
    
    constraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:(kStatusBarHeight + kNavBarHeight)];
    constraint.priority = 790;
    [self.view addConstraint: constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:subHeaderPart attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-50.0];
    constraint.priority = 801;
    [self.view addConstraint: constraint];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self fillBlurredImageCache];
//    });
    
    [self.tableView reloadData];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    [self performSelector:@selector(showTableView) withObject:nil afterDelay:2];
    [self performSelector:@selector(setViewForFirstTime) withObject:nil afterDelay:0.2];
}
// To Show Hide Table View at the time of Data Downloading
-(void)showTableView{
    self.tableView.hidden=NO;
    self.tableView.tableFooterView=[UIView new];
    [JTProgressHUD hide];
}

// Set up View for First Time
-(void)setViewForFirstTime{
    if (badgeView==nil) {
        [self addNotificationView];
    }
    [self setupTableAfterClick];
    
}
- (void) configureNavBar {
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,0,25,25);
    btn.titleLabel.font =[UIFont fontWithName:fontIcomoon size:25];
    [btn setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(menuToggle) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem =   barBtn;
    [self switchToExpandedHeader];
}


- (void)switchToExpandedHeader
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.titleView = nil;
    _barAnimationComplete = false;
    self.imageHeaderView.image = self.originalBackgroundImage;
    [self.tableView.tableHeaderView exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
}

- (void)switchToMinifiedHeader
{
    _barAnimationComplete = false;
    self.navigationItem.titleView = self.customTitleView;
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:60 forBarMetrics:UIBarMetricsDefault];
    [self.tableView.tableHeaderView exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yPos = scrollView.contentOffset.y;
    if (yPos > _headerSwitchOffset && !_barIsCollapsed) {
        [self switchToMinifiedHeader];
        _barIsCollapsed = true;
    } else if (yPos < _headerSwitchOffset && _barIsCollapsed) {
        [self switchToExpandedHeader];
        _barIsCollapsed = false;
    }
    if(yPos > _headerSwitchOffset +20 && yPos <= _headerSwitchOffset +20 +40){
        CGFloat delta = (40 +20 - (yPos-_headerSwitchOffset));
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:delta forBarMetrics:UIBarMetricsDefault];
       // self.imageHeaderView.image = [self blurWithImageAt:((60-delta)/60.0)];
    }
    if(!_barAnimationComplete && yPos > _headerSwitchOffset +20 +40) {
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
      //  self.imageHeaderView.image = [self blurWithImageAt:1.0];
        _barAnimationComplete = true;
    }
}
- (UIImageView*) createAvatarImage {
    UIImageView* avatarView = [[UIImageView alloc] init];
    avatarView.contentMode = UIViewContentModeScaleToFill;
    [avatarView addWhiteLayerAndCornerRadius:mainUserProfileICornerRadius AndWidth:borderWidth_Image];
    avatarView.clipsToBounds = YES;
    return avatarView;
}
- (UIView*) customTitleView {
    if(!_customTitleView){
        UILabel* myLabel = [UILabel new];
        myLabel.translatesAutoresizingMaskIntoConstraints = NO;
        myLabel.text =_name;
        myLabel.numberOfLines =1;
        [myLabel setTextColor:[UIColor whiteColor]];
        [myLabel setFont:[UIFont fontWithName:font_bold size:font_size_button]];
        UILabel* smallText = [UILabel new];
        smallText.translatesAutoresizingMaskIntoConstraints = NO;
        smallText.text = @"";
        smallText.numberOfLines =1;
        [smallText setTextColor:[UIColor whiteColor]];
        [smallText setFont:[UIFont fontWithName:font_regular size:font_size_normal_regular]];
        UIView* wrapper = [UIView new];
        [wrapper addSubview:myLabel];
        [wrapper addSubview:smallText];
        [wrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[myLabel]-0-|" options:0 metrics:nil views:@{@"myLabel": myLabel,@"smallText":smallText}]];
        [wrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[myLabel]-2-[smallText]-0-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"myLabel": myLabel,@"smallText":smallText}]];
        wrapper.frame = CGRectMake(0, 0, MAX(myLabel.intrinsicContentSize.width,smallText.intrinsicContentSize.width), myLabel.intrinsicContentSize.height + smallText.intrinsicContentSize.height + 2);
        wrapper.clipsToBounds = true;
        _customTitleView  = wrapper;
    }
    return _customTitleView;
}

- (UIView*) createSubHeaderView {
    UIView* view = [UIView new];
    NSMutableDictionary* views = [NSMutableDictionary new];
    views[@"super"] = self.view;
    UIButton* followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    followButton.translatesAutoresizingMaskIntoConstraints = NO;
    [followButton setTitle:@"" forState:UIControlStateNormal];
    followButton.layer.cornerRadius = cornerRadius_Button;
    followButton.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    followButton.layer.borderWidth =1;
    [followButton addShaddow];
    followButton.hidden=YES;
    followButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    followButton.backgroundColor=userShouldDOButoonColor;
    [followButton addTarget:self action:@selector(tappedOnUserImage) forControlEvents:UIControlEventTouchUpInside];
    views[@"followButton"] = followButton;
    [view addSubview:followButton];
    UILabel* nameLabel = [UILabel new];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.text = _name;
    nameLabel.numberOfLines =1;
    [nameLabel setFont:[UIFont fontWithName:font_bold size:font_size_bold]];
    views[@"nameLabel"] = nameLabel;
    [view addSubview:nameLabel];
    NSArray* constraints;
    NSString* format;
    format = @"[followButton]-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [view addConstraints:constraints];
    format = @"|-[nameLabel]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [view addConstraints:constraints];
    format = @"V:|-[followButton]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [view addConstraints:constraints];
    format = @"V:|-60-[nameLabel]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [view addConstraints:constraints];
    return view;
}

- (UIImage *)blurWithImageAt:(CGFloat)percent
{
    NSNumber* keyNumber = @0;
    if(percent <= 0.1){
        keyNumber = @1;
    } else if(percent <= 0.2) {
        keyNumber = @2;
    } else if(percent <= 0.3) {
        keyNumber = @3;
    } else if(percent <= 0.4) {
        keyNumber = @4;
    } else if(percent <= 0.5) {
        keyNumber = @5;
    } else if(percent <= 0.6) {
        keyNumber = @6;
    } else if(percent <= 0.7) {
        keyNumber = @7;
    } else if(percent <= 0.8) {
        keyNumber = @8;
    } else if(percent <= 0.9) {
        keyNumber = @9;
    } else if(percent <= 1) {
        keyNumber = @10;
    }
    UIImage* image = [_blurredImageCache objectForKey:keyNumber];
    if(image == nil){
        return _originalBackgroundImage;
    }
    return image;
}
- (UIImage *)blurWithImageEffects:(UIImage *)image andRadius: (CGFloat) radius
{
    return [image applyBlurWithRadius:radius tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.5 maskImage:nil];
}
- (void) fillBlurredImageCache {
    CGFloat maxBlur = 30;
    self.blurredImageCache = [NSMutableDictionary new];
    for (int i = 0; i <= 10; i++)
    {
        self.blurredImageCache[[NSNumber numberWithInt:i]] = [self blurWithImageEffects:_originalBackgroundImage andRadius:(maxBlur * i/10)];
    }
}


#pragma mark====================Tapped On User Profile Image===============================

-(void)tappedOnUserImage{
    ViewUserProfileViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewUserProfileViewController"];
    vc.userID=_userId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark====================Memory Release===============================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view.window){
        /*strong ref to this*/
        _customTitleView = nil;
    }
}
- (void)dealloc{
    _originalBackgroundImage = nil;
    [_blurredImageCache removeAllObjects];
    _blurredImageCache = nil;
}



#pragma mark====================Table view data source===============================
-(void)reloadTable{
    [self.tableView reloadData];
    [self.view hideLoader];
    [self performSelector:@selector(afterReloadScroll) withObject:nil afterDelay:0.3];
    
    if (selectedIndex==0) {
        if(homeFeedData.count==0){
            [self.view makeToast:[NSString stringWithFormat:@" %@ Have No Feeds",_name]duration:toastDuration position:toastPositionBottomUp];
        }
    }else   if (selectedIndex==1) {
        if( visitedCitiesData.count==0){
            [self.view makeToast:[NSString stringWithFormat:@" %@ hand no city visited yet !!!",_name] duration:toastDuration position:toastPositionBottomUp];
        }
    }else   if (selectedIndex==2) {
        if(wishToData.count==0){
            [self.view makeToast:[NSString stringWithFormat:@"No cities is found in %@'s wishlist destinations",_name] duration:toastDuration position:toastPositionBottomUp];
        }
    }else   if (selectedIndex==3) {
        if( followerData.count==0){
            [self.view makeToast:[NSString stringWithFormat:@"No one is following %@",_name] duration:toastDuration position:toastPositionBottomUp];
        }
    }else   if (selectedIndex==4) {
        if(followingData.count==0){
            [self.view makeToast:[NSString stringWithFormat:@" %@ dont follow anyone",_name]duration:toastDuration position:toastPositionBottomUp];
        }
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex==0) {
        return homeFeedData.count;
    }else   if (selectedIndex==1) {
        return visitedCitiesData.count;
    }else   if (selectedIndex==2) {
        return wishToData.count;
    }else   if (selectedIndex==3) {
        return followerData.count;
    }else   if (selectedIndex==4) {
        return followingData.count;
    }else
        return 0;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    if (selectedIndex==0) {
        UINib *nib = [UINib nibWithNibName:@"FeedsTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"FeedsTableViewCell"];
        FeedsTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"FeedsTableViewCell"];
        
        //created dictionary from array object
        NSDictionary * dataDict =[homeFeedData objectAtIndex:indexPath.row];
        
        NSString * miliseconds =[NSString stringWithFormat:@"%@",[dataDict valueForKey:@"add_date"]];
        
        [cell.agoLbl setAgoText:miliseconds];
        
        //detail text
        NSString * details =[dataDict valueForKey:@"activity_description"];
        cell.extraFeedLabel.text=details;
        
        //Checked for User Image
        NSString * urlStringForProfileImage =[dataDict valueForKey:@"userImage"];
        if (![urlStringForProfileImage isKindOfClass:[NSNull class]]) {
            NSURL * profileUrl =[NSURL URLWithString:urlStringForProfileImage];
            [cell.profileImage sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
        }
        [cell.profileImage addShaddow];
        
        //Checked for post Image
        NSString * urlStringForPostImage =[[[dataDict valueForKey:@"image"]lastObject]valueForKey:@"image"];
        NSURL * url =[NSURL URLWithString:urlStringForPostImage] ;
        if (![url isKindOfClass:[NSNull class]]) {
                  [cell.postImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Placeholder"]];
        }
        
        //On Click of Image Should Open
        cell.profileImage.userInteractionEnabled=YES;
        cell.profileImage.tag=indexPath.row;
        UITapGestureRecognizer *tapRecognizerq = [[UITapGestureRecognizer alloc] init];
        [tapRecognizerq addTarget:self action:@selector(clickedOnProfileImage:)];
        [cell.profileImage addGestureRecognizer:tapRecognizerq];
        
        //On Click of Image Should Open
        cell.postImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
        [tapRecognizer addTarget:self action:@selector(clickedOnPostImage:)];
        [cell.postImage addGestureRecognizer:tapRecognizer];
        
        //
        NSString *userName;
        NSString *cityName;
        NSString * userID;
        NSString * locId;
        NSString * imageUrl;
        NSArray *refertitle =[dataDict valueForKey:@"refertitle"];
        if (refertitle!=nil) {
            userName=[[refertitle objectAtIndex:0]valueForKey:@"name"];
            cityName=[[refertitle objectAtIndex:1]valueForKey:@"name"];
            userID =[dataDict valueForKey:@"posted_by"];
            locId =[[refertitle objectAtIndex:1]valueForKey:@"id"];
            imageUrl =[[refertitle objectAtIndex:1]valueForKey:@"image"];
        }
        
        //mainstr have title and Also Links Managed.
        NSString * mainTitleStr =[NSString stringWithFormat:@"%@",[dataDict valueForKey:@"activity_title"]];
        
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to eat"
                                                                withString:@"to eat 🍕 "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to visit"
                                                                withString:@"to visit 🌄  "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to shopping"
                                                                withString:@"to shopping 👗 "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to stay"
                                                                withString:@"to stay 🏠 "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"travelling to"
                                                                withString:@"travelling to ✈️ "];
        
        cell.mainTitle.numberOfLines = 0;
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_regular size:font_size_normal_regular]};
        cell.mainTitle.attributedText = [[NSAttributedString alloc]initWithString:mainTitleStr attributes:attributes];
        
        void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
            if ([substring isEqualToString:userName]) {
                [self openUserProfile:userID :userName: urlStringForProfileImage];
            }else   if ([substring isEqualToString:cityName]) {
                [self openLocationFeedView:locId :cityName :imageUrl];
            }
        };
        //Added link substrings
        if (cityName!=nil && userName!=nil) {
            NSMutableArray * substringArr =[NSMutableArray new];
            if (![cityName isKindOfClass:[NSNull class]]) {
                [substringArr addObject:cityName];
            }
            if (![userName isKindOfClass:[NSNull class]]) {
                [substringArr addObject:userName];
            }
            [substringArr addObject:@"to eat 🍕"];
            [substringArr addObject:@"to visit 🌄  "];
            [substringArr addObject:@"to shopping 👗 "];
            [substringArr addObject:@"to stay 🏠 "];
            [substringArr addObject:@"travelling to ✈️ "];
            [cell.mainTitle clearActionDictionary];
            [cell.mainTitle setLinksForSubstrings:substringArr withLinkHandler:handler];
        }
        
        
        //Managed Comments View
        int isCommentByYou=[[dataDict valueForKey:@"is_my"]intValue];
        int coments =[[dataDict valueForKey:@"total_comments"]intValue];
        if (isCommentByYou==1) {
            if (coments==0) {
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"No Comments Yet !"];
                cell.comentMenuTextLbl.textColor=[UIColor lightGrayColor];
                cell.comentMenuLbl.textColor =[UIColor lightGrayColor];
            }else if(coments==1){
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"You had Commented"];
                cell.comentMenuTextLbl.textColor =[UIColor redColor];
                cell.comentMenuLbl.textColor=[UIColor blackColor];
            }else{
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"%d Comments + 1 You",coments-1];
                cell.comentMenuLbl.textColor =[UIColor redColor];
                cell.comentMenuLbl.textColor=[UIColor blackColor];
            }
            
        }else{
            
            if (coments==0) {
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"No Comments Yet !"];
                cell.comentMenuTextLbl.textColor=[UIColor lightGrayColor];;
                cell.comentMenuLbl.textColor =[UIColor lightGrayColor];
            }else if(coments==1){
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"%d Comment",coments];
                cell.comentMenuTextLbl.textColor=[UIColor blackColor];
                cell.comentMenuLbl.textColor =[UIColor blackColor];
            }else{
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"%d Comments",coments];
                cell.comentMenuTextLbl.textColor=[UIColor blackColor];
                cell.comentMenuLbl.textColor =[UIColor blackColor];
            }
        }
        
        // Managed Like View
        int isLikedByYou=[[dataDict valueForKey:@"is_like"]intValue];
        if (isLikedByYou==1) {
            int like =[[dataDict valueForKey:@"total_like"]intValue];
            if (like==0) {
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"No Likes Yet !"];
                cell.likeMenuTxtLbl.textColor=[UIColor lightGrayColor];
                cell.likeMenuLogoLbl.textColor =[UIColor blueColor];
            }else if(like==1){
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"%d Your Like",like];
                cell.likeMenuLogoLbl.textColor =[UIColor redColor];
                cell.likeMenuTxtLbl.textColor=[UIColor blackColor];
            }else{
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"%d Likes + 1 You",like-1];
                cell.likeMenuLogoLbl.textColor =[UIColor redColor];
                cell.likeMenuTxtLbl.textColor=[UIColor blackColor];
            }
            
        }else{
            int like =[[dataDict valueForKey:@"total_like"]intValue];
            if (like==0) {
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"No Likes Yet !"];
                cell.likeMenuTxtLbl.textColor=[UIColor lightGrayColor];;
                cell.likeMenuLogoLbl.textColor =[UIColor blueColor];
            }else if(like==1){
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"%d Like",like];
                cell.likeMenuTxtLbl.textColor=[UIColor blackColor];
                cell.likeMenuLogoLbl.textColor =[UIColor blueColor];
            }else{
                cell.likeMenuTxtLbl.text =[NSString stringWithFormat:@"%d Likes",like];
                cell.likeMenuTxtLbl.textColor=[UIColor blackColor];
                cell.likeMenuLogoLbl.textColor =[UIColor blueColor];
            }
        }
        
        
        cell.likeBtn.tag=indexPath.row;
        cell.commentBtn.tag=indexPath.row;
        cell.likeThumbBtn.tag=indexPath.row;
        cell.menuBtnOfPost.tag=indexPath.row;
        
        [cell.likeBtn addTarget:self action:@selector(openLikeMenu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentBtn addTarget:self action:@selector(openCommentMenu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeThumbBtn addTarget:self action:@selector(justDoLike:) forControlEvents:UIControlEventTouchUpInside];
        [cell.menuBtnOfPost addTarget:self action:@selector(editPost:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.contentView layoutIfNeeded];
        
        // For Paging Mechanism
        if (indexPath.row==homeFeedData.count -3) {
            if (homeFeedPageShouldDoPaging==YES) {
                homeFeedPage++;
                [self performSelectorInBackground:@selector(getHomeFeedDataForPaging) withObject:nil];
            }
        }
        
        return cell;
        
    }else if (selectedIndex==1){
        
        UINib *nib = [UINib nibWithNibName:@"WishedToTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"WishedToTableViewCell"];
        WishedToTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"WishedToTableViewCell"];
        NSDictionary * dataDict =[visitedCitiesData objectAtIndex:indexPath.row];
        
        NSString * city =[dataDict valueForKey:@"city"];
        NSString * country =[dataDict valueForKey:@"country"];
        NSString * state =[dataDict valueForKey:@"state"];
        
        if (![city isKindOfClass:[NSNull class]]&&![state isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:state]) {
                cell.mainTitle.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.mainTitle.text =[NSString stringWithFormat:@" %@ , %@ ",city , state];
            }
        }else{
            cell.mainTitle.text =@"City Name Not Available Now";
        }
        
        if (![country isKindOfClass:[NSNull class]]) {
            cell.subTitleLbl.text=country;
        }else {
            cell.subTitleLbl.text=@"Country Name Not Available Now";
        }
        
        //Checked for post Image
        NSString * urlStringForImage =[dataDict valueForKey:@"image"];
        if (![urlStringForImage isKindOfClass:[NSNull class]]) {
            NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
            [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
        }
        
        // For Paging Mechanism
        if (indexPath.row==visitedCitiesData.count -3) {
            if (visitedCitiesPageShouldDoPaging==YES) {
                visitedCitiesPage++;
                [self performSelectorInBackground:@selector(getVisitedCitiesDataForPaging) withObject:nil];
            }
        }
        cell.deleteButton.hidden=YES;
        cell.deleteButton.tag=indexPath.row;
        [cell.deleteButton addTarget:self action:@selector(deletePlaceVisited:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (selectedIndex==2){
        
        UINib *nib = [UINib nibWithNibName:@"WishedToTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"WishedToTableViewCell"];
        WishedToTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"WishedToTableViewCell"];
        
        NSDictionary * dataDict =[wishToData objectAtIndex:indexPath.row];
        
        NSString * city =[dataDict valueForKey:@"city"];
        NSString * country =[dataDict valueForKey:@"country"];
        NSString * state =[dataDict valueForKey:@"state"];
        
        if (![city isKindOfClass:[NSNull class]]&&![state isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:state]) {
                cell.mainTitle.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.mainTitle.text =[NSString stringWithFormat:@" %@ , %@ ",city , state];
            }
        }else{
            cell.mainTitle.text =@"City Name Not Available Now";
        }
        
        if (![country isKindOfClass:[NSNull class]]) {
            cell.subTitleLbl.text=country;
        }else {
            cell.subTitleLbl.text=@"Country Name Not Available Now";
        }
        
        //Checked for post Image
        NSString * urlStringForImage =[dataDict valueForKey:@"image"];
        if (![urlStringForImage isKindOfClass:[NSNull class]]) {
            NSURL * profileUrl =[NSURL URLWithString:urlStringForImage];
            [cell.profileImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"No_User"]];
        }
        
        // For Paging Mechanism
        if (indexPath.row==wishToData.count -3) {
            if (wishToPageShouldDoPaging==YES) {
                wishToPage++;
                [self performSelectorInBackground:@selector(getWishDataForPaging) withObject:nil];
            }
        }
        
        cell.deleteButton.tag=indexPath.row;
        [cell.deleteButton addTarget:self action:@selector(deleteWishTo:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteButton.hidden=YES;
        return cell;
        
    }else if (selectedIndex==3){
        UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
        FollowingTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
        
        NSDictionary * dataDict =[followerData objectAtIndex:indexPath.row];
        NSString * city =[dataDict valueForKey:@"city"];
        NSString * country =[dataDict valueForKey:@"country"];
        NSString * name =[dataDict valueForKey:@"name"];
        
        if (![city isKindOfClass:[NSNull class]]&&![country isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:country]) {
                cell.addressLbl.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.addressLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city , country];
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
        if (indexPath.row==followerData.count -3) {
            if (followerPageShouldDoPaging==YES) {
                followerPage++;
                [self performSelectorInBackground:@selector(getWishDataForPaging) withObject:nil];
            }
        }
        if ([[dataDict valueForKey:@"follow"]integerValue]==1) {
            [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
            cell.followButton.backgroundColor=Uncheck_Color;
        }else{
            [cell.followButton setTitle:@"Follow" forState:UIControlStateNormal];
            cell.followButton.backgroundColor=Check_Color;
        }
        
        
        if ([[dataDict valueForKey:@"mid"] isEqualToString: [UserData getUserID]]) {
            cell.followButton.hidden=YES;
        }else{
            cell.followButton.hidden=NO;
        }
        
        cell.followButton.tag=indexPath.row;
        [cell.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (selectedIndex==4){
        
        UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
        FollowingTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
        
        NSDictionary * dataDict =[followingData objectAtIndex:indexPath.row];
        NSString * city =[dataDict valueForKey:@"city"];
        NSString * country =[dataDict valueForKey:@"country"];
        NSString * name =[dataDict valueForKey:@"name"];
        
        if (![city isKindOfClass:[NSNull class]]&&![country isKindOfClass:[NSNull class]]) {
            if ([city isEqualToString:country]) {
                cell.addressLbl.text =[NSString stringWithFormat:@" %@ ",city];
            }else {
                cell.addressLbl.text =[NSString stringWithFormat:@" %@ , %@ ",city , country];
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
        if (indexPath.row==followerData.count -3) {
            if (followerPageShouldDoPaging==YES) {
                followerPage++;
                [self performSelectorInBackground:@selector(getWishDataForPaging) withObject:nil];
            }
        }
        
        cell.followButton.tag=indexPath.row;
        [cell.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[dataDict valueForKey:@"mid"] isEqualToString: [UserData getUserID]]) {
            cell.followButton.hidden=YES;
        }else{
            cell.followButton.hidden=NO;
        }
        
        if ([[dataDict valueForKey:@"follow"]integerValue]==1) {
            [cell.followButton setTitle:@"Following" forState:UIControlStateNormal];
            cell.followButton.backgroundColor=Uncheck_Color;
        }else{
            [cell.followButton setTitle:@"Follow" forState:UIControlStateNormal];
            cell.followButton.backgroundColor=Check_Color;
        }
        
        return cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex==3){
        NSDictionary * dict =[followerData objectAtIndex:indexPath.row];
        NSString * uid=[dict valueForKey:@"mid"];
        NSString * name=[dict valueForKey:@"name"];
        NSString * imageUrl =[dict valueForKey:@"image"];
        [self openUserProfile:uid :name :imageUrl];
    }
    if (selectedIndex==4) {
        NSDictionary * dict =[followingData objectAtIndex:indexPath.row];
        NSString * uid=[dict valueForKey:@"mid"];
        NSString * name=[dict valueForKey:@"name"];
        NSString * imageUrl =[dict valueForKey:@"image"];
        [self openUserProfile:uid :name :imageUrl];
        
    }
    if (selectedIndex==2) {
        NSDictionary * dict =[wishToData objectAtIndex:indexPath.row];
        NSString * cityid=[dict valueForKey:@"id"];
        NSString * name=[dict valueForKey:@"city"];
        NSString * image=[dict valueForKey:@"image"];
        [self openLocationFeedView:cityid :name :image];
    }
    if (selectedIndex==1) {
        NSDictionary * dict =[visitedCitiesData objectAtIndex:indexPath.row];
        NSString * cityid=[dict valueForKey:@"id"];
        NSString * name=[dict valueForKey:@"city"];
        NSString * image=[dict valueForKey:@"image"];
        [self openLocationFeedView:cityid :name :image];
    }
}

#pragma mark====================Set up Segment here===============================
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray * namesOfMenus =@[@"Feeds",@"Places Visited",@"Wish To",@"Followers",@"Following"];
    
    myScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 2, self.tableView.frame.size.width, 40)];
    CGFloat scrollWidth = 0.f;
    buttonArray=[[NSMutableArray alloc]init];
    for ( int j=0; j<namesOfMenus.count; j++)
    {
        NSString * name =[namesOfMenus objectAtIndex:j];
        CGSize size = [name sizeWithAttributes:
                       @{NSFontAttributeName: [UIFont fontWithName:font_bold size:font_size_button]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        CGFloat strikeWidth;
        if (iPAD) {
            strikeWidth = self.view.frame.size.width/5.5;
        }else{
            strikeWidth = textSize.width;
        }
        CGRect frame = CGRectMake(scrollWidth, 0,strikeWidth+20, 40);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:j];
        button.frame = frame;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.textColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderColor=[UIColor whiteColor].CGColor;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:name forState:UIControlStateNormal];
        
        scrollWidth= scrollWidth+strikeWidth+20;
        
        if (j==selectedIndex) {
            button.backgroundColor=segment_selected_Color ;
            [button setTitleColor:segment_disselected_Color forState:UIControlStateNormal];
            [button addLayerAndCornerRadius:0 AndWidth:1 AndColor:segment_disselected_Color];
            [button addShaddow];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }else {
            button.backgroundColor=segment_disselected_Color;
            [button addLayerAndCornerRadius:0 AndWidth:0 AndColor:segment_disselected_Color];;
            [button setTitleColor:segment_selected_Color forState:UIControlStateNormal];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }
        
        
        [buttonArray addObject:button];
        [myScrollView addSubview:button];
        
    }
    myScrollView.contentSize = CGSizeMake(scrollWidth, 30.f);
    myScrollView.pagingEnabled = NO;
    myScrollView.backgroundColor=[UIColor whiteColor];
    
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    [myScrollView setShowsVerticalScrollIndicator:NO];
    return myScrollView;
    
}

#pragma mark====================On Selection of Segment===============================
-(void)buttonEvent:(UIButton*)sender
{
    NSInteger index= sender.tag;
    selectedIndex= (int) index;
    
    for(int i=0;i<buttonArray.count;i++)
    {
        UIButton * button =(UIButton*)[buttonArray objectAtIndex:i];
        if (i==selectedIndex) {
            button.backgroundColor=segment_selected_Color ;
            [button setTitleColor:segment_disselected_Color forState:UIControlStateNormal];
            [button addLayerAndCornerRadius:0 AndWidth:1 AndColor:segment_disselected_Color];
            [button addShaddow];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }else {
            button.backgroundColor=segment_disselected_Color;
            [button addLayerAndCornerRadius:0 AndWidth:0 AndColor:segment_disselected_Color];
            [button setTitleColor:segment_selected_Color forState:UIControlStateNormal];
            if (iPhone6||iPhone6plus) {
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }else{
                button.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
            }
        }
    }
    
    CGRect frame1 = myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:index];
    frame1 =bt.frame ;
    [myScrollView scrollRectToVisible:frame1 animated:YES];
    [self setupTableAfterClick];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}


-(void)setupTableAfterClick{
    
    NSArray *imagesArray = @[@"Place",@"Food",@"Visited",@"Follower",@"Following",@"Accomodation",@"Shopping"];
    NSString *imageName = [imagesArray objectAtIndex:(arc4random() % imagesArray.count)];
    self.imageHeaderView.image=[UIImage imageNamed:imageName];
    
    if (selectedIndex==0) {
        self.tableView.estimatedRowHeight=200;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableView.separatorColor = [UIColor clearColor];
    }else if (selectedIndex==1){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tableView.separatorColor = [UIColor lightGrayColor];;
    }else if (selectedIndex==2){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tableView.separatorColor = [UIColor lightGrayColor];
    }else if (selectedIndex==3){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tableView.separatorColor = [UIColor lightGrayColor];
    }else if (selectedIndex==4){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        
    }
    [self.view showLoader];
    [self performSelector:@selector(callWebservicesAsButtonClick) withObject:nil afterDelay:0.3];
}
-(void)afterReloadScroll{
    CGRect frame1 = myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:selectedIndex];
    frame1 =bt.frame ;
    [myScrollView scrollRectToVisible:frame1 animated:YES];
}
-(void)callWebservicesAsButtonClick{
    switch (selectedIndex) {
            //=====================1st click ====================
        case 0:
        {
            if (homeFeedData.count==0) {
                [self performSelectorInBackground:@selector(getHomeFeedData) withObject:nil];
            }else{
                if (firstTimePageOpen==NO) {
                    [self.view hideLoader];
                    [self reloadTable];
                }
            }
        }break;
            //=====================2st click ====================
        case 1:
            if (visitedCitiesData.count==0) {
                [self performSelectorInBackground:@selector(getVisitedCitiesData) withObject:nil];
            }
            else{
                [self.view hideLoader];
                [self reloadTable];
            }
            break;
            //=====================3st click ====================
        case 2:
            if (wishToData.count==0) {
                [self performSelectorInBackground:@selector(getWishData) withObject:nil];
            }else{
                [self.view hideLoader];
                [self reloadTable];
            }
            break;
            //=====================4st click ====================
        case 3:
                followerData=[NSMutableArray new];
                [self performSelectorInBackground:@selector(getFollowerData) withObject:nil];
            
            break;
            //=====================5st click ====================
        case 4:
                followingData=[NSMutableArray new];
                [self performSelectorInBackground:@selector(getFollowListData) withObject:nil];
           
            break;
        default:
            break;
    }
}

#pragma mark====================Edit User Feed Post=============================
-(void)editPost:(UIButton*)btn{
    
    selectedDictForDelete =[homeFeedData objectAtIndex:btn.tag];
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Traweller"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    UIAlertAction* edit = [UIAlertAction
                           actionWithTitle:@"Edit"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [self editPost];
                               [self dismissViewControllerAnimated:YES completion:nil];
                           }];
    UIAlertAction* delete = [UIAlertAction
                             actionWithTitle:@"Delete"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 [self doDeleteOfFeed];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    UIAlertAction* share = [UIAlertAction
                            actionWithTitle:@"Share"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self performSelector:@selector(sharePost:) withObject:btn afterDelay:1];
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }];
    
    
    NSString * userID;
    
    NSArray *refertitle =[selectedDictForDelete valueForKey:@"refertitle"];
    if (refertitle!=nil) {
        userID =[[refertitle objectAtIndex:0]valueForKey:@"id"];
    }
    
    [view addAction:ok];
    [view addAction:share];
    
    if ([userID isEqualToString:[UserData getUserID]]) {
        [view addAction:edit];
        [view addAction:delete];
    }
    
    CGPoint windowPoint = [btn convertPoint:btn.bounds.origin toView:self.view.window];
    view.popoverPresentationController.sourceView = self.view;
    view.popoverPresentationController.sourceRect = CGRectMake(btn.frame.origin.x, windowPoint.y+15, btn.frame.size.width, btn.frame.size.height);;
    [self presentViewController: view animated:YES completion:nil];
    
}
-(void)editPost{
    AddPostViewController * vc= [self.storyboard instantiateViewControllerWithIdentifier:@"AddPostViewController"];
    vc.EditPostDirectory=selectedDictForDelete;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sharePost:(UIButton *)btn{
    
    //detail text
    NSString * details =[selectedDictForDelete valueForKey:@"activity_description"];
    
    //Checked for post Image
    UIImageView * tempImageView =[UIImageView new];
    NSString * urlStringForPostImage =[[[selectedDictForDelete valueForKey:@"image"]lastObject]valueForKey:@"image"];
    if (![urlStringForPostImage isKindOfClass:[NSNull class]]) {
        NSURL * profileUrl =[NSURL URLWithString:urlStringForPostImage];
        [tempImageView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"PlaceHolder"]];
    }
    
    NSString * mainTitleStr =[NSString stringWithFormat:@"%@",[selectedDictForDelete valueForKey:@"activity_title"]];
    
    mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to eat"
                                                            withString:@"to eat 🍕 "];
    mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to visit"
                                                            withString:@"to visit 🌄  "];
    mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to shopping"
                                                            withString:@"to shopping 👗 "];
    mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to stay"
                                                            withString:@"to stay 🏠 "];
    mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"travelling to"
                                                            withString:@"travelling to ✈️ "];
    
    NSString * str =@"Post is Shared From Traweller App.";
    UIImage *imagetoshare = tempImageView.image;
    NSArray *activityItems = @[mainTitleStr, imagetoshare,details,str];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeOpenInIBooks,UIActivityTypeAirDrop,UIActivityTypeMessage];
    
    //if iPhone
    if (!iPAD) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        
        CGPoint windowPoint = [btn convertPoint:btn.bounds.origin toView:self.view.window];
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        [popup presentPopoverFromRect: CGRectMake(btn.frame.origin.x, windowPoint.y+15, btn.frame.size.width, btn.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}


#pragma mark======delete========
-(void)deletePlaceVisited:(UIButton*)btn{
    [self showAlert];
    selectedDictForDelete =[visitedCitiesData objectAtIndex:btn.tag];
}
-(void)deleteWishTo:(UIButton*)btn{
    [self showAlert];
    selectedDictForDelete =[wishToData objectAtIndex:btn.tag];
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

#pragma mark====================Open Location Feeds=============================
-(void)openLocationFeedView:(NSString *)locationId :(NSString *)locName :(NSString *)photoUrl{
    LocationFeedViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LocationFeedViewController"];
    vc.cityId=locationId;
    vc.name=locName;
    vc.imageUrl=photoUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark====================Open Who Likes the Post=============================
-(void)openLikeMenu:(UIButton*)btn{
    BOOL shouldOpenMenu =NO;
    indexForLikeNotification=(int)btn.tag;
    NSDictionary * dataDict =[homeFeedData objectAtIndex:btn.tag];
    int isLikedByYou=[[dataDict valueForKey:@"is_like"]intValue];
    if (isLikedByYou==1) {
        int like =[[dataDict valueForKey:@"total_like"]intValue];
        if (like==0) {
            shouldOpenMenu=NO;
            [self.view makeToast:@"No one like the post yet"duration:toastDuration position:toastPositionBottomUp];
        }else if(like==1){
            shouldOpenMenu=NO;
            [self.view makeToast:@"Only you had liked the post"duration:toastDuration position:toastPositionBottomUp];
        }else{
            shouldOpenMenu=YES;
        }
        
    }else{
        int like =[[dataDict valueForKey:@"total_like"]intValue];
        if (like==0) {
            shouldOpenMenu=NO;
            [self.view makeToast:@"No one like the post yet" duration:toastDuration position:toastPositionBottomUp];
        }else if(like==1){
            shouldOpenMenu=YES;
        }else{
            shouldOpenMenu=YES;
        }
    }
    if (shouldOpenMenu==YES) {
        
        LikeViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LikeViewController"];
        newVC.activityId=[dataDict valueForKey:@"id"];
        newVC.userId=[dataDict valueForKey:@"posted_by"];
        [self setPresentationStyleForSelfController:self presentingController:newVC];
        UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:newVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma mark====================Like the Post=============================
-(void)justDoLike:(UIButton*)btn{
    
    FeedsTableViewCell *cell = (FeedsTableViewCell *)btn.superview.superview.superview.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary * dataDict =[homeFeedData objectAtIndex:indexPath.row];
    
    if ([[dataDict valueForKey:@"is_like"]intValue] == 1) {
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dataDict];
        [newDict setObject:@"0" forKey:@"is_like"];
        int like =[[dataDict valueForKey:@"total_like"]intValue];
        like--;
        [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_like"];
        [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
        [self.view makeToast:@"You removed your like of the post"duration:toastDuration position:toastPositionBottomUp];
        
    }else{
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        [newDict addEntriesFromDictionary:dataDict];
        [newDict setObject:@"1" forKey:@"is_like"];
        int like =[[dataDict valueForKey:@"total_like"]intValue];
        like++;
        [newDict setObject:[NSString stringWithFormat:@"%d",like] forKey:@"total_like"];
        [homeFeedData replaceObjectAtIndex:indexPath.row withObject:newDict];
        [self.view makeToast:@"You liked the post"duration:toastDuration position:toastPositionBottomUp];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    forLike=dataDict;
    [self performSelectorInBackground:@selector(likeWebservice) withObject:nil];
}

-(void)likeWebservice{
    NSString * postid =[forLike valueForKey:@"id"];
    NSString * posted_by =[forLike valueForKey:@"posted_by"];
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicID=%@&activityId=%@",URL_CONST,ACTION_ADD_LIKE,userID,posted_by,postid];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [followingData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

#pragma mark====================Open Who commented on the Post=============================
-(void)openCommentMenu:(UIButton*)btn{
    NSDictionary * dataDict =[homeFeedData objectAtIndex:btn.tag];
    indexForCommentNotification=btn.tag;
    CommentsViewController * v =[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsViewController"];
    v.activityId=[dataDict valueForKey:@"id"];
    v.postedById=[dataDict valueForKey:@"posted_by"];
    [self setPresentationStyleForSelfController:self presentingController:v];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:v];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark ====================FollowMechanism=============================
-(void)followButtonClick:(UIButton *)btn{
    selectedUserIdex =(int)btn.tag;
    ipForFollow =[NSIndexPath indexPathForRow:selectedUserIdex inSection:0];
    [self.view showLoader];
    [self performSelectorInBackground:@selector(followWebservice) withObject:nil];
}
-(void)followWebservice{
    NSDictionary * dataDict ;
    if (selectedIndex==3) {
        dataDict =[followerData objectAtIndex:selectedUserIdex];
    }else{
        dataDict =[followingData objectAtIndex:selectedUserIdex];
    }
    
    NSString * publicId =[dataDict valueForKey:@"mid"];
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@",URL_CONST,ACTION_ADD_FOLLOWER, userID,publicId];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [self performSelectorOnMainThread:@selector(reloadTableRow:) withObject:homefeed waitUntilDone:YES];
}

-(void)reloadTableRow:(NSDictionary *)homefeed{
    
    
    if (selectedIndex==3) {
        NSDictionary * dataDict =[followerData objectAtIndex:selectedUserIdex];
        if (homefeed) {
            if ([[homefeed valueForKey:@"message"]isEqualToString:@"you are now following the user"]) {
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"1" forKey:@"follow"];
                [followerData replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are now following the user"duration:toastDuration position:toastPositionBottomUp];
            }else{
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"0" forKey:@"follow"];
                [followerData replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are NOT following the user now"duration:toastDuration position:toastPositionBottomUp];
            }
        }
        
        [self.tableView reloadRowsAtIndexPaths:@[ipForFollow] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.view hideLoader];
        
    }else{
        if (homefeed) {
            NSDictionary * dataDict =[followingData objectAtIndex:selectedUserIdex];
            if ([[homefeed valueForKey:@"message"]isEqualToString:@"you are now following the user"]) {
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"1" forKey:@"follow"];
                [followingData replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are now following the user"duration:toastDuration position:toastPositionBottomUp];
            }else{
                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                [newDict addEntriesFromDictionary:dataDict];
                [newDict setObject:@"0" forKey:@"follow"];
                [followingData replaceObjectAtIndex:selectedUserIdex withObject:newDict];
                [self.view makeToast:@"You are NOT following the user now"duration:toastDuration position:toastPositionBottomUp];
            }
        }
        [self.tableView reloadData];
        [self.view hideLoader];
    }
}

#pragma mark====================For Presenting Like/Comment Menu Proper=============================
- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    presentingController.providesPresentationContextTransitionStyle = YES;
    presentingController.definesPresentationContext = YES;
    [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}

#pragma mark====================Open/Hide Menu=============================
-(void)menuToggle{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark====================Get HomeFeed Data From Webservice=============================
-(void)getHomeFeedData{
    
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@&page=%d",URL_CONST,ACTION_GET_USER_ACTIVITY,userID,_userId,homeFeedPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [homeFeedData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    
    if (firstTimePageOpen==YES) {
        [self performSelectorOnMainThread:@selector(setHomeView) withObject:nil waitUntilDone:YES];
        firstTimePageOpen=NO;
    }else{
         [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    }
}

-(void)getHomeFeedDataForPaging{
    
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@&page=%d",URL_CONST,ACTION_GET_USER_ACTIVITY,userID,_userId,homeFeedPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        homeFeedPageShouldDoPaging=NO;
    }else{
        [homeFeedData addObjectsFromArray:data];
        homeFeedPageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

#pragma mark====================Get Follower Data Data From Webservice=============================
-(void)getFollowerData{
    
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_MY_FOLLOW_LIST,_userId,followerPage];
    followerPage=1;
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [followerData addObjectsFromArray:[dict valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

-(void)getFollowerDataForPaging{
    
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&publicId=%@&page=%d",URL_CONST,ACTION_GET_MY_FOLLOW_LIST,userID,_userId,followerPage];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[dict valueForKey:@"data"];
    if (data.count==0) {
        followerPageShouldDoPaging=NO;
    }else{
        [followerData addObjectsFromArray:data];
        followerPageShouldDoPaging=YES;
    }
    
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

#pragma mark====================Get Follow List Data From Webservice=============================
-(void)getFollowListData{
    
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d&publicId=%@",URL_CONST,ACTION_GET_FOLLOWER_LIST,userID,followingPage,_userId];
    followingPage=1;
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [followingData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    
}

-(void)getFollowListDataForPaging{
    
    NSString * userID =[UserData getUserID];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_FOLLOWER_LIST,_userId,followingPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        followingPageShouldDoPaging=NO;
    }else{
        [followingData addObjectsFromArray:data];
        followingPageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

#pragma mark====================Get Wish Data From Webservice=============================
-(void)getWishData{
    NSString * userID =_userId;
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_WISH_TO,userID,wishToPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [wishToData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

-(void)getWishDataForPaging{
    
    NSString * userID =_userId;
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_WISH_TO,userID,wishToPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        wishToPageShouldDoPaging=NO;
    }else{
        [wishToData addObjectsFromArray:data];
        wishToPageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

#pragma mark====================Get Visited Cities From Webservice=============================
-(void)getVisitedCitiesData{
    
    NSString * userID =_userId;
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_VISITED_CITIES,userID,visitedCitiesPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [visitedCitiesData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    
}

-(void)getVisitedCitiesDataForPaging{
    
    NSString * userID =_userId;
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,ACTION_GET_VISITED_CITIES,userID,visitedCitiesPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    NSArray * data =[homefeed valueForKey:@"data"];
    if (data.count==0) {
        visitedCitiesPageShouldDoPaging=NO;
    }else{
        [visitedCitiesData addObjectsFromArray:data];
        visitedCitiesPageShouldDoPaging=YES;
    }
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}


#pragma mark====================Open image properly =============================
-(void)clickedOnPostImage:(UITapGestureRecognizer *)sender {
    
    UIImageView * imageview =(UIImageView *) sender.view;
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = imageview.image;
    imageInfo.referenceRect = imageview.frame;
    imageInfo.referenceView = self.view;
    imageInfo.referenceContentMode = imageview.contentMode;
    imageInfo.referenceCornerRadius = imageview.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}
-(void)clickedOnProfileImage:(UITapGestureRecognizer *)sender{
    int index=(int) sender.view.tag;
    //created dictionary from array object
    NSDictionary * dataDict =[homeFeedData objectAtIndex:index];
    NSString *userName;
    NSString *cityName;
    NSString * userID;
    NSString * urlStringForProfileImage =[dataDict valueForKey:@"userImage"];
    NSArray *refertitle =[dataDict valueForKey:@"refertitle"];
    if (refertitle!=nil) {
        userName=[[refertitle objectAtIndex:0]valueForKey:@"name"];
        cityName=[[refertitle objectAtIndex:1]valueForKey:@"name"];
        userID =[dataDict valueForKey:@"posted_by"];
        [self openUserProfile:userID :userName: urlStringForProfileImage];
    }
    
}

#pragma mark ==== Delete===
-(void)showAlert{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Traweller"
                                 message:@"Do you want to delete ?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction* delete = [UIAlertAction
                             actionWithTitle:@"Delete"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 if (selectedIndex==0) {
                                     [self doDeleteOfFeed];
                                 }else if(selectedIndex==2){
                                     [self doDeleteWishedTo];
                                 }
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    
    
    
    [view addAction:ok];
    [view addAction:delete];
    view.popoverPresentationController.sourceRect = self.tableView.frame;
    [self presentViewController: view animated:YES completion:nil];
    
}
-(void)doDeleteOfFeed{
    [homeFeedData containsObject:selectedDictForDelete];
    NSInteger i =  [homeFeedData indexOfObject:selectedDictForDelete];
    [homeFeedData removeObjectAtIndex:i];
    NSIndexPath * ip =[NSIndexPath indexPathForItem:i inSection:0];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    [self performSelectorInBackground:@selector(feedDeleteWebservice) withObject:nil];
}
-(void)doDeleteWishedTo{
    [wishToData containsObject:selectedDictForDelete];
    NSInteger i =  [wishToData indexOfObject:selectedDictForDelete];
    [wishToData removeObjectAtIndex:i];
    NSIndexPath * ip =[NSIndexPath indexPathForItem:i inSection:0];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}
-(void)feedDeleteWebservice{
    NSString * taskID =[selectedDictForDelete valueForKey:@"id"];
    NSString * type = [selectedDictForDelete valueForKey:@"activity_type"];
    NSString * apiURL=[NSString stringWithFormat:@"http://trasquare.com/traveller_api/checkurl.php?action=%@&userId=%@&&taskId=%@&type=%@",ACTION_FEED_DELETE,[UserData getUserID],taskID,type];
    [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    
}
@end
