//
//  SettingViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
#import "TravellerConstants.h"

@interface SettingViewController : UIViewController
{
   GIBadgeView * badgeView;
    //Push Notification
    __weak IBOutlet UIView *pushNotificationBackView;
    __weak IBOutlet UILabel *pushNotificationLbl;
    __weak IBOutlet UISwitch *pushNotificationSwitch;
    __weak IBOutlet UILabel *pushNotificationDetailTxt;
    
    //Push Notification
    __weak IBOutlet UIView *editProfileBackView;
    __weak IBOutlet UILabel *editProfileLbl;
    __weak IBOutlet UILabel *editProfileDetailTxt;
    
    //Push Notification
    __weak IBOutlet UIView *changePasswordBackView;
    __weak IBOutlet UILabel *changePasswordLbl;
    
    __weak IBOutlet UITextView *detailsTextView;
 
}
- (IBAction)pushClick:(UISwitch *)sender;
- (IBAction)editClick:(UIButton *)sender;
- (IBAction)chengePasswordClick:(UIButton *)sender;
@end
