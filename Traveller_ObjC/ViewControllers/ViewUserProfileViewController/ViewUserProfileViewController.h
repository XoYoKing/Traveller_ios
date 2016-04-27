//
//  ViewUserProfileViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewUserProfileViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>
{
    __weak IBOutlet UILabel *infoTitleLbl;
     __weak IBOutlet UILabel * userNameLbl;
     __weak IBOutlet UILabel * statusLbl;
     __weak IBOutlet UIImageView * userImageView;
    __weak IBOutlet UILabel *followingTitleLbl;
    __weak IBOutlet UILabel *following;
    __weak IBOutlet UILabel *followerTitleLbl;
    __weak IBOutlet UILabel *follower;
    __weak IBOutlet UIButton *writeMsgBtn;
    __weak IBOutlet UIButton *followBtn;
    __weak IBOutlet NSLayoutConstraint *tableHeight;
    NSMutableArray * userdataArray;
    __weak IBOutlet UIView *imageBackgroundView;
    
    __weak IBOutlet UIButton *changeImageButton;
    UIImagePickerController *ipc;
    UIPopoverController *popover;
    __weak IBOutlet UIImageView *backgroundImageView;
    
}


@property (weak, nonatomic) IBOutlet UITableView *viewProfileTableView;
@property(strong,nonatomic)NSString * userID;
@property(assign,nonatomic)BOOL fromMenu;
- (IBAction)changeImageButtonClick:(id)sender;

- (IBAction)followClick:(id)sender;
- (IBAction)messgeClick:(id)sender;
@end
