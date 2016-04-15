//
//  WishToVisitViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 15/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowingTableViewCell.h"
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
@interface WishToVisitViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    __weak IBOutlet UITableView *wishToTableView;
    GIBadgeView * badgeView;
    
    NSMutableArray * globalArrayToShow;
    NSMutableArray * citiesArray;
    BOOL citiesPagingBoolean;
    int citiesPage;
    
    __weak IBOutlet UITextField *searchTF;
    __weak IBOutlet UIButton *searchBtn;
    
}

@property(strong,nonatomic)NSDictionary * selectedCityDict;
@end
