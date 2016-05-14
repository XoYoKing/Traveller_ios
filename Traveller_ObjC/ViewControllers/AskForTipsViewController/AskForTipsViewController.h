//
//  AskForTipsViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 15/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowingTableViewCell.h"
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
@interface AskForTipsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    __weak IBOutlet UITableView *wishToTableView;
    GIBadgeView * badgeView;
    
    NSMutableArray * globalArrayToShow;
    NSMutableArray * citiesArray;
    BOOL citiesPagingBoolean;
    int flag ;
    int citiesPage;
    
    __weak IBOutlet UITextField *searchTF;
    __weak IBOutlet UIButton *searchBtn;
    __weak IBOutlet UITextView *textView;
    __weak IBOutlet UIButton *sendButton;
    __weak IBOutlet NSLayoutConstraint *textViewHeight;
    __weak IBOutlet NSLayoutConstraint *searchViewaboveConstraint;
    __weak IBOutlet UIView *searchBackView;
    int selectedIndex;
}

@property(strong,nonatomic)NSString * ivitepeople;
@property(strong,nonatomic)NSDictionary * selectedCityDict;
@property(strong,nonatomic)NSString * forWhichMenu;
- (IBAction)sendClick:(id)sender;


@end
