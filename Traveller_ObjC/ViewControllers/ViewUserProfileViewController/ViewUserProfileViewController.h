//
//  ViewUserProfileViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewUserProfileViewController : UIViewController
{
    __weak IBOutlet UILabel *infoTitleLbl;

    __weak IBOutlet NSLayoutConstraint *imageAboveHeight;
     __weak IBOutlet UILabel * userNameLbl;
     __weak IBOutlet UILabel * statusLbl;
     __weak IBOutlet UIImageView * userImageView;
    __weak IBOutlet UILabel *followingTitleLbl;
    __weak IBOutlet UILabel *following;
    __weak IBOutlet UILabel *followerTitleLbl;
    __weak IBOutlet UILabel *follower;
    __weak IBOutlet UIButton *writeMsgBtn;
    __weak IBOutlet UIButton *followBtn;
    __weak IBOutlet UILabel *followLogo;
    __weak IBOutlet UILabel *messageLogo;
    __weak IBOutlet NSLayoutConstraint *tableHeight;
    NSMutableArray * userdataArray;
}


@property (weak, nonatomic) IBOutlet UITableView *viewProfileTableView;
@property(strong,nonatomic)NSString * userID;

- (IBAction)followClick:(id)sender;
- (IBAction)messgeClick:(id)sender;
@end
