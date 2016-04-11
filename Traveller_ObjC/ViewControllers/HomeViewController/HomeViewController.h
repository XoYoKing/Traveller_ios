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

@interface HomeViewController : UIViewController
{
        UIScrollView * myScrollView;
        GIBadgeView * badgeView;
    
        NSMutableArray * buttonArray;
        NSMutableArray * homeFeedData;

        CGFloat _headerHeight;
        CGFloat _subHeaderHeight;
        CGFloat _headerSwitchOffset;
        CGFloat _avatarImageSize;
        CGFloat _avatarImageCompressedSize;
    
        BOOL _barIsCollapsed;
        BOOL _barAnimationComplete;
        BOOL homeFeedPageShouldDoPaging;
    
        int homeFeedPage;
        //int homeFeedPage;
        //int homeFeedPage;
        //int homeFeedPage;
        int selectedIndex;
    
    }
    
    @property (weak) UITableView *tableView;
    @property (weak) UIImageView *imageHeaderView;
    @property (weak) UIVisualEffectView *visualEffectView;
    @property (strong,nonatomic) UIView *customTitleView;
    @property (strong) UIImage *originalBackgroundImage;
    @property (strong) NSMutableDictionary* blurredImageCache;

@end
