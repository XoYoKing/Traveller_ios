//
//  HomeViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImage+ImageEffects.h"
#import "TravellerConstants.h"
#import "JASidePanelController.h"
#import "ViewProfileController.h"
#import "LocationFeedViewController.h"
#import "LikeViewController.h"
#import "CommentsViewController.h"
#import "Toast+UIView.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _headerHeight;
    CGFloat _subHeaderHeight;
    CGFloat _headerSwitchOffset;
    CGFloat _avatarImageSize;
    CGFloat _avatarImageCompressedSize;
    BOOL _barIsCollapsed;
    BOOL _barAnimationComplete;
    
}

@property (weak) UITableView *tableView;
@property (weak) UIImageView *imageHeaderView;
@property (weak) UIVisualEffectView *visualEffectView;
@property (strong,nonatomic) UIView *customTitleView;
@property (strong) UIImage *originalBackgroundImage;

@property (strong) NSMutableDictionary* blurredImageCache;



@end

@implementation HomeViewController

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
-(void)removeShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 0;
    view.layer.shadowOpacity = 0;
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
    badgeView.badgeValue = 5;
    [self addShaddowToView:notificationButton];
    [self.view addSubview:notificationButton];
    [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)setViewForFirstTime{
    if (badgeView==nil) {
        [self addNotificationView];
    }
    [self setupTableAfterClick];
    [JTProgressHUD hide];
}

-(void)viewDidAppear:(BOOL)animated{
  
    if (self.tableView==nil) {
          [JTProgressHUD show];
    [self performSelectorInBackground:@selector(getHomeFeedData) withObject:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    homeFeedData=[NSMutableArray new];
    selectedIndex=0;
    homeFeedPage=1;
    homeFeedPageShouldDoPaging=YES;
}

-(void)setHomeView{
     [self configureNavBar];
    _headerHeight = 150.0;
    _subHeaderHeight = 100.0;
    _avatarImageSize = 100;
    _avatarImageCompressedSize = 44;
    _barIsCollapsed = false;
    _barAnimationComplete = false;
    
    
    self.tableView.estimatedRowHeight=50;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView reloadData];
    
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
    
    UIImage* bgImage = [UIImage imageNamed:@"alpes.jpg"];
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
    avatarImageView.translatesAutoresizingMaskIntoConstraints = NO; //autolayout
    views[@"avatarImageView"] = avatarImageView;
    avatarImageView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [avatarImageView addGestureRecognizer:tap];
    
    
    [tableHeaderView addSubview:avatarImageView];
    
    /*
     * At this point tableHeader views are ordered like this:
     * 0 : subHeaderPart
     * 1 : headerImageView
     * 2 : avatarImageView
     */
    
    /* This is important, or section header will 'overlaps' the navbar */
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fillBlurredImageCache];
    });

    [self.tableView reloadData];
    [self performSelector:@selector(showTableView) withObject:nil afterDelay:0.2];
     [self performSelector:@selector(setViewForFirstTime) withObject:nil afterDelay:0.2];
}
-(void)showTableView{
    self.tableView.hidden=NO;
}


-(void)handleImageTap{
    
}

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
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex==0) {
        return homeFeedData.count;
    }else
    return 25;
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
        //mainstr have title
        NSString * mainTitleStr =[NSString stringWithFormat:@"%@",[dataDict valueForKey:@"activity_title"]];
        
      mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to eat"
                                       withString:@"to eat 🍕 "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to visit"
                                                                withString:@"to visit 🌄  "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to shopping"
                                                                withString:@"to shopping 👗 "];
        mainTitleStr =  [mainTitleStr stringByReplacingOccurrencesOfString:@"to stay"
                                                                withString:@"to stay 🏠 "];
        
        cell.mainTitle.numberOfLines = 0;
        //detail text
        NSString * details =[dataDict valueForKey:@"activity_description"];
        cell.extraFeedLabel.text=details;
        
        NSString * urlStringForProfileImage =[dataDict valueForKey:@"userImage"];
        if (![urlStringForProfileImage isKindOfClass:[NSNull class]]) {
            NSURL * profileUrl =[NSURL URLWithString:urlStringForProfileImage];
            [cell.profileImage sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"avatar.jpg"]];
        }
        
        NSString * urlStringForPostImage =[[[dataDict valueForKey:@"image"]lastObject]valueForKey:@"image"];
        if (![urlStringForPostImage isKindOfClass:[NSNull class]]) {
            NSURL * profileUrl =[NSURL URLWithString:urlStringForPostImage];
            [cell.postImage sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"alpes.jpg"]];
        }
        NSString *userName;
        NSString *cityName;
        NSArray *refertitle =[dataDict valueForKey:@"refertitle"];
        if (refertitle!=nil) {
            userName=[[refertitle objectAtIndex:0]valueForKey:@"name"];
            cityName=[[refertitle objectAtIndex:1]valueForKey:@"name"];
        }
 
        NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_family_regular size:12]};
        cell.mainTitle.attributedText = [[NSAttributedString alloc]initWithString:mainTitleStr attributes:attributes];
        
        void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
            if ([substring isEqualToString:userName]) {
                [self openUserProfile];
            }else{
                [self openLocationFeedView];
            }
        };


        //Step 3: Add link substrings
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
            [cell.mainTitle setLinksForSubstrings:substringArr withLinkHandler:handler];
        }

        int isCommentByYou=[[dataDict valueForKey:@"is_my"]intValue];
        int coments =[[dataDict valueForKey:@"total_comments"]intValue];
        if (isCommentByYou==1) {
            if (coments==0) {
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"No Comments Yet !"];
                cell.comentMenuTextLbl.textColor=[UIColor lightGrayColor];
                cell.comentMenuLbl.textColor =[UIColor lightGrayColor];
            }else if(coments==1){
                cell.comentMenuLbl.text =[NSString stringWithFormat:@"You had Commented"];
                cell.comentMenuLbl.textColor =[UIColor redColor];
                cell.comentMenuTextLbl.textColor=[UIColor blackColor];
            }else{
                cell.comentMenuTextLbl.text =[NSString stringWithFormat:@"%d Comments + 1 You",coments-1];
                cell.comentMenuLbl.textColor =[UIColor redColor];
                cell.comentMenuTextLbl.textColor=[UIColor blackColor];
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
        
        [cell.likeBtn addTarget:self action:@selector(openLikeMenu:) forControlEvents:UIControlEventTouchUpInside];
          [cell.commentBtn addTarget:self action:@selector(openCommentMenu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeThumbBtn addTarget:self action:@selector(justDoLike:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView layoutIfNeeded];
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
        return cell;
    }else if (selectedIndex==2){
        UINib *nib = [UINib nibWithNibName:@"WishedToTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"WishedToTableViewCell"];
        WishedToTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"WishedToTableViewCell"];
        return cell;
    }else if (selectedIndex==3){
        UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
        FollowingTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
        return cell;
    }else if (selectedIndex==4){
        UINib *nib = [UINib nibWithNibName:@"FollowingTableViewCell" bundle:nil];
        [[self tableView] registerNib:nib forCellReuseIdentifier:@"FollowingTableViewCell"];
        FollowingTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"FollowingTableViewCell"];
        return cell;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray * namesOfMenus =@[@"Feeds",@"Places Visited",@"Wish To",@"Followers",@"Following"];
    
     myScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
            CGFloat scrollWidth = 0.f;
            buttonArray=[[NSMutableArray alloc]init];
            for ( int j=0; j<namesOfMenus.count; j++)
            {
                NSString * name =[namesOfMenus objectAtIndex:j];
                CGSize size = [name sizeWithAttributes:
                               @{NSFontAttributeName: [UIFont fontWithName:font_family_regular size:17]}];
                CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
                CGFloat strikeWidth = textSize.width;
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
                       button.backgroundColor= Check_All_Button_Color;
                    button.layer.borderColor=[UIColor whiteColor].CGColor;
                    [self addShaddowToView:button];
                    if (iPhone6||iPhone6plus) {
                        button.titleLabel.font=[UIFont fontWithName:font_family_regular size:17];
                    }else {
                        button.titleLabel.font=[UIFont fontWithName:font_family_regular size:15];
                    }
                }else {
                    button.backgroundColor= [UIColor blackColor];
                    [self removeShaddowToView:button];
                    button.layer.borderColor=[UIColor whiteColor].CGColor;
                    if (iPhone6||iPhone6plus) {
                        button.titleLabel.font=[UIFont fontWithName:font_family_regular size:17];
                    }else{
                        button.titleLabel.font=[UIFont fontWithName:font_family_regular size:15];
                    }
                }
                
                [buttonArray addObject:button];
                [myScrollView addSubview:button];
                
            }
            myScrollView.contentSize = CGSizeMake(scrollWidth, 30.f);
            myScrollView.pagingEnabled = NO;
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    [myScrollView setShowsVerticalScrollIndicator:NO];
    return myScrollView;
    
}


#pragma mark - Header Button Action
-(void)buttonEvent:(UIButton*)sender
{
    NSInteger index= sender.tag;
    selectedIndex=index;
    
    for(int i=0;i<buttonArray.count;i++)
            {
                if(i==index)
                {
                    UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
                    btn.backgroundColor= Check_All_Button_Color;
                    [self addShaddowToView:btn];

                }
                else{
                    UIButton * btn = (UIButton *) [buttonArray objectAtIndex:i];
                     btn.backgroundColor=[UIColor blackColor];
                    [self removeShaddowToView:btn];
                }
            }

    
    
    CGRect frame1 = myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:index];
    frame1 =bt.frame ;
    [myScrollView scrollRectToVisible:frame1 animated:YES];
    [self setupTableAfterClick];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}


-(void)setupTableAfterClick{
    if (selectedIndex==0) {
        self.tableView.estimatedRowHeight=200;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
    }else if (selectedIndex==1){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
    }else if (selectedIndex==2){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
    }else if (selectedIndex==3){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
    }else if (selectedIndex==4){
        self.tableView.estimatedRowHeight=130;
        self.tableView.rowHeight=UITableViewAutomaticDimension;
    }
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView reloadData];
    [self performSelector:@selector(afterReloadScroll) withObject:nil afterDelay:0.3];
}
-(void)afterReloadScroll{
    CGRect frame1 = myScrollView.frame;
    UIButton * bt=(UIButton*)[buttonArray objectAtIndex:selectedIndex];
    frame1 =bt.frame ;
    [myScrollView scrollRectToVisible:frame1 animated:YES];
}

#pragma mark - NavBar configuration

- (void) configureNavBar {
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,0,25,25);
    btn.titleLabel.font =[UIFont fontWithName:fontIcomoon size:25];
    
    [btn setTitle:[NSString stringWithUTF8String:ICOMOON_MENU] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(menuToggle) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem =   barBtn;
    [self switchToExpandedHeader];
}

-(void)menuToggle{
    
    AppDelegate *d = [[UIApplication sharedApplication] delegate];
    [d.drawerView showLeftPanelAnimated:YES ];
}

- (void)switchToExpandedHeader
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.titleView = nil;
    //    if(self.visualEffectView){
    //        [self.visualEffectView removeFromSuperview];
    //        self.visualEffectView = nil;
    //    }
    
    _barAnimationComplete = false;
    self.imageHeaderView.image = self.originalBackgroundImage;
    
    
    //Inverse Z-Order of avatar Image view
    [self.tableView.tableHeaderView exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    
}

- (void)switchToMinifiedHeader
{
    //    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //    visualEffectView.frame = self.imageHeaderView.bounds;
    //    self.visualEffectView = visualEffectView;
    //    [self.imageHeaderView addSubview:visualEffectView];
    
    _barAnimationComplete = false;
    
    self.navigationItem.titleView = self.customTitleView;
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    //Setting the view transform or changing frame origin has no effect, only this call does
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:60 forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationItem.titleView updateConstraintsIfNeeded];
    
    //Inverse Z-Order of avatar Image view
    [self.tableView.tableHeaderView exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
}


#pragma mark - UIScrollView delegate

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
    
    //appologies for the magic numbers
    if(yPos > _headerSwitchOffset +20 && yPos <= _headerSwitchOffset +20 +40){
        CGFloat delta = (40 +20 - (yPos-_headerSwitchOffset));
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:delta forBarMetrics:UIBarMetricsDefault];
        
        self.imageHeaderView.image = [self blurWithImageAt:((60-delta)/60.0)];
        
    }
    if(!_barAnimationComplete && yPos > _headerSwitchOffset +20 +40) {
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
        self.imageHeaderView.image = [self blurWithImageAt:1.0];
        _barAnimationComplete = true;
    }
    
}


#pragma mark - privates

- (UIImageView*) createAvatarImage {
    UIImageView* avatarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
    avatarView.contentMode = UIViewContentModeScaleToFill;
    avatarView.layer.cornerRadius = 8.0;
    avatarView.layer.borderWidth = 3.0f;
    avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarView.clipsToBounds = YES;
     return avatarView;
}

- (UIView*) customTitleView {
    if(!_customTitleView){
        UILabel* myLabel = [UILabel new];
        myLabel.translatesAutoresizingMaskIntoConstraints = NO;
        myLabel.text = @"Sagar Shirbhate";
        myLabel.numberOfLines =1;
        
        [myLabel setTextColor:[UIColor whiteColor]];
        [myLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        
        
        
        UILabel* smallText = [UILabel new];
        smallText.translatesAutoresizingMaskIntoConstraints = NO;
        smallText.text = @"";
        smallText.numberOfLines =1;
        
        [smallText setTextColor:[UIColor whiteColor]];
        [smallText setFont:[UIFont boldSystemFontOfSize:10.0f]];
        
        
        UIView* wrapper = [UIView new];
        [wrapper addSubview:myLabel];
        [wrapper addSubview:smallText];
        
        
        
        [wrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[myLabel]-0-|" options:0 metrics:nil views:@{@"myLabel": myLabel,@"smallText":smallText}]];
        [wrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[myLabel]-2-[smallText]-0-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"myLabel": myLabel,@"smallText":smallText}]];
        
        //mmm.. it seems that i have to set it like this, if not the view size is set to 0 by the navabar layout..
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
    
    UIButton* followButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    followButton.translatesAutoresizingMaskIntoConstraints = NO;
    [followButton setTitle:@"" forState:UIControlStateNormal];
    followButton.layer.cornerRadius = 0;
    followButton.layer.borderWidth = 0;
    followButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    views[@"followButton"] = followButton;
    [view addSubview:followButton];
    
    UILabel* nameLabel = [UILabel new];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.text = @"Sagar Shirbhate";
    nameLabel.numberOfLines =1;
    [nameLabel setFont:[UIFont fontWithName:@"Futura" size:18]];
    views[@"nameLabel"] = nameLabel;
    [view addSubview:nameLabel];
    
    
    
    NSArray* constraints;
    NSString* format;
    //NSDictionary* metrics;
    
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
        //TODO if cache not yet built, just compute and put in cache
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




-(void)openUserProfile{
    ViewProfileController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewProfileController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)openLocationFeedView{
    LocationFeedViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LocationFeedViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)openLikeMenu:(UIButton*)btn{
    BOOL shouldOpenMenu =NO;
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
    [self setPresentationStyleForSelfController:self presentingController:newVC];
      UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:newVC];
    [self presentViewController:nav animated:YES completion:nil];
    }
}

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
    
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
  }

-(void)openCommentMenu:(UIButton*)btn{
    CommentsViewController * v =[self.storyboard instantiateViewControllerWithIdentifier:@"CommentsViewController"];
     [self setPresentationStyleForSelfController:self presentingController:v];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:v];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}




-(void)getHomeFeedData{
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    NSDictionary * userDict =[defaults objectForKey:@"UserDict"];
    
    NSString * userID =[[[userDict valueForKey:@"data"]lastObject]valueForKey:@"id"];
      NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,GET_MY_ACTIVITY,userID,homeFeedPage];
    NSDictionary * homefeed = [[WebHandler sharedHandler]getDataFromWebservice:apiURL];
    [homeFeedData addObjectsFromArray:[homefeed valueForKey:@"data"]];
    [self performSelectorOnMainThread:@selector(setHomeView) withObject:nil waitUntilDone:YES];
}

-(void)getHomeFeedDataForPaging{
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    NSDictionary * userDict =[defaults objectForKey:@"UserDict"];
    NSString * userID =[[[userDict valueForKey:@"data"]lastObject]valueForKey:@"id"];
    NSString *apiURL =  [NSString stringWithFormat:@"%@action=%@&userId=%@&page=%d",URL_CONST,GET_MY_ACTIVITY,userID,homeFeedPage];
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
-(void)reloadTable{
     [self.tableView reloadData];
}

@end
