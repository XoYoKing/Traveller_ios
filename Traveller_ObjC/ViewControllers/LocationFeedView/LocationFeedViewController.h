//
//  LocationFeedViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
#import "FeedsTableViewCell.h"
#import "WishedToTableViewCell.h"
#import "FollowingTableViewCell.h"
#import "FRHyperLabel.h"

@interface LocationFeedViewController : UIViewController
{
    UIScrollView * myScrollView;
    GIBadgeView * badgeView;
    
    NSMutableArray * buttonArray;
    NSMutableArray * homeFeedData;
    NSMutableArray * followerData;
    NSMutableArray * followingData;
    NSMutableArray * wishToData;
    NSMutableArray * visitedCitiesData;
    
    CGFloat _headerHeight;
    CGFloat _subHeaderHeight;
    CGFloat _headerSwitchOffset;
    CGFloat _avatarImageSize;
    CGFloat _avatarImageCompressedSize;
    
    BOOL _barIsCollapsed;
    BOOL _barAnimationComplete;
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
@property(strong,nonatomic)NSString * cityId;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * imageUrl;
@property (weak) UITableView *tableView;
@property (weak) UIImageView *imageHeaderView;
@property (weak) UIVisualEffectView *visualEffectView;
@property (strong,nonatomic) UIView *customTitleView;
@property (strong) UIImage *originalBackgroundImage;
@property (strong) NSMutableDictionary* blurredImageCache;

@end
