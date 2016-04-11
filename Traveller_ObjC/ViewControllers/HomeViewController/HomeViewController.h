//
//  HomeViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
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
#import "WebHandler.h"
#import "JTProgressHUD.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

@interface HomeViewController : UIViewController
{
    NSMutableArray * buttonArray;
    NSInteger selectedIndex;
    UIScrollView * myScrollView;
    GIBadgeView * badgeView;
    
    NSMutableArray * homeFeedData;
    int homeFeedPage;
    BOOL homeFeedPageShouldDoPaging;
}

@end
