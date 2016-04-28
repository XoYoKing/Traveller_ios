//
//  HomeViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//


#import "FeedsTableViewCell.h"
#import "WishedToTableViewCell.h"
#import "FollowingTableViewCell.h"
#import "RFRateMe.h"
#import "UIAlertView+NSCookbook.h"
@interface HomeViewController : UIViewController
{
        UIScrollView * myScrollView; // For Segment
        GIBadgeView * badgeView; // For Notification Badge View
        UIImageView* avatarImageView; // Main Profile Imageview
    
        NSMutableArray * buttonArray; // Segment Button Array
        NSMutableArray * homeFeedData; // Home feed Data array
        NSMutableArray * followerData; //// follower data Array
        NSMutableArray * followingData; // Following Data Array
        NSMutableArray * wishToData; // Wish to Data Array
        NSMutableArray * visitedCitiesData; // Visited Cities Data array

#pragma mark++++++++++Dont Touch this is for Scrolling Effect++++++++++
        CGFloat _headerHeight;
        CGFloat _subHeaderHeight;
        CGFloat _headerSwitchOffset;
        CGFloat _avatarImageSize;
        CGFloat _avatarImageCompressedSize;
        BOOL _barIsCollapsed;
        BOOL _barAnimationComplete;
#pragma mark ++++++++++++++++++++++++++++++++++++++++++++++
    
        BOOL firstTimePageOpen;
        BOOL homeFeedPageShouldDoPaging;
        BOOL visitedCitiesPageShouldDoPaging;
        BOOL wishToPageShouldDoPaging;
        BOOL followerPageShouldDoPaging;
        BOOL followingPageShouldDoPaging;
    
        int homeFeedPage;
        int followerPage;
        int followingPage;
        int wishToPage;
        int visitedCitiesPage;
        int selectedIndex;
        int selectedUserIdex;
        int indexForLikeNotification;
        int indexForCommentNotification;
    
    NSDictionary * forLike;
    NSDictionary * selectedDictForDelete;
    NSIndexPath * ipForFollow;
    }
    
    @property (weak) UITableView *tableView;
    @property (weak) UIImageView *imageHeaderView;
    @property (weak) UIVisualEffectView *visualEffectView;
    @property (strong,nonatomic) UIView *customTitleView;
    @property (strong) UIImage *originalBackgroundImage;
    @property (strong) NSMutableDictionary* blurredImageCache;

@end
