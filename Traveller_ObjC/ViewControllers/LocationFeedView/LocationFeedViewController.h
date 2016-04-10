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
    NSMutableArray * buttonArray;
    NSInteger selectedIndex;
    UIScrollView * myScrollView;
    GIBadgeView * badgeView;
    
}

@end
