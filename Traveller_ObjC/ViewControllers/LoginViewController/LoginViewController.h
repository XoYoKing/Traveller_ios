//
//  LoginViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCIntroView.h"
#import <Google/SignIn.h>
@interface LoginViewController : UIViewController<ABCIntroViewDelegate,GIDSignInDelegate,GIDSignInDelegate,GIDSignInUIDelegate>
{
    IBOutlet UIImageView *logoImage;
    IBOutlet TextFieldValidator *userNameTextField;
    IBOutlet TextFieldValidator *passwordTextField;
    IBOutlet UILabel *usernameLogo;
    IBOutlet UILabel *passwordLogo;
    IBOutlet UIButton *showHidePasswordBtn;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *forgetPasswordBtn;
    IBOutlet UIButton *needAnAccountBtn;
    IBOutlet UILabel *orLbl;
    IBOutlet UIButton *googleBtn;
    IBOutlet UIButton *faceBookButton;
    IBOutlet NSLayoutConstraint *aboveConstraint;
    NSDictionary * fbdict;
    NSDictionary * googleDict;
}
@property ABCIntroView *introView;

- (IBAction)facebookClick:(id)sender;
- (IBAction)googleClick:(id)sender;
- (IBAction)loginClick:(id)sender;
- (IBAction)showHidePasswordClick:(id)sender;
- (IBAction)forgetClick:(id)sender;
- (IBAction)signUpClick:(id)sender;
@end
