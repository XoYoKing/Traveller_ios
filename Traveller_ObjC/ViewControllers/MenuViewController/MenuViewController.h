//
//  MenuViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h" 
#import "CitiesViewController.h"
#import "SearchViewController.h"
#import "TravellingToViewController.h"
#import "HomeViewController.h"
#import "ViewProfileController.h"
#import "NotificationsViewController.h"
#import "SettingViewController.h"
#import "HomeViewController.h"
#import "GIBadgeView.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    GIBadgeView * badgeView;
    __weak IBOutlet UITableView *menuTableView;
    __weak IBOutlet UIView *notificationView;
}
@end
