//
//  NotificationsViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravellerConstants.h"
#import "GIBadgeView.h"
#import "Notification1TableViewCell.h"
#import "Notification2TableViewCell.h"
#import "Notification3TableViewCell.h"
#import "Notification4TableViewCell.h"
@interface NotificationsViewController : UIViewController<UITextViewDelegate>
{
    __weak IBOutlet UIScrollView *myScrollView;
    NSMutableArray * buttonArray;
    NSInteger selectedIndex;
    __weak IBOutlet UITableView *notificationTableView;
    
    NSMutableArray * invitation;
    NSMutableArray * ask_for_tip;
    NSMutableArray * follow ;
    NSMutableArray * message;
    
    NSDictionary * itemDelete;
    NSString * msgForService;
}
@property(assign)BOOL fromMenu;
@end
