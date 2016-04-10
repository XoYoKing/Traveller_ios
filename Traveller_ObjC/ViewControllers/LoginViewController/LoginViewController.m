//
//  LoginViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 07/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "LoginViewController.h"
#import "TravellerConstants.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "JASidePanelController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}


-(void)setUpView{
    if (iPhone6||iPhone6plus||iPad) {
        aboveConstraint.constant =100;
        [self.view layoutIfNeeded];
        forgetPasswordBtn.titleLabel.font=[UIFont fontWithName:font_family_regular size:14];
        needAnAccountBtn.titleLabel.font=[UIFont fontWithName:font_family_regular size:14];
    }else{
        forgetPasswordBtn.titleLabel.font=[UIFont fontWithName:font_family_regular size:12];
        needAnAccountBtn.titleLabel.font=[UIFont fontWithName:font_family_regular size:12];
    }
    userNameTextField.font=[UIFont fontWithName:font_family_regular size:font_family_regular_size];
     passwordTextField.font=[UIFont fontWithName:font_family_regular size:font_family_regular_size];
    usernameLogo.font=[UIFont fontWithName:fontIcomoon size:font_family_regular_size];
    passwordLogo.font=[UIFont fontWithName:fontIcomoon size:font_family_regular_size];
    showHidePasswordBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    loginButton.titleLabel.font=[UIFont fontWithName:font_family_regular size:font_family_regular_size];
 
    orLbl.font=[UIFont fontWithName:font_family_regular size:font_family_regular_size];
    googleBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    faceBookButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    usernameLogo.text =[NSString stringWithUTF8String:ICOMOON_USER];
    passwordLogo.text =[NSString stringWithUTF8String:ICOMOON_KEY];
     [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE_CLOSED] forState:UIControlStateNormal];
    [googleBtn setTitle:[NSString stringWithUTF8String:ICOMOON_GOOGLE] forState:UIControlStateNormal];
    [faceBookButton setTitle:[NSString stringWithUTF8String:ICOMOON_FACEBOOK] forState:UIControlStateNormal];
    [userNameTextField setLeftPadding:35];
    [passwordTextField setLeftPadding:35];
    [userNameTextField setRightPadding:35];
    [passwordTextField setRightPadding:35];
    loginButton.layer.borderColor=[UIColor blackColor].CGColor;
    loginButton.layer.borderWidth=1;
    loginButton.layer.cornerRadius=4;
    [self addShaddowToView:loginButton];
}
-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebookClick:(id)sender {
}

- (IBAction)googleClick:(id)sender {
}

- (IBAction)loginClick:(id)sender {
   JASidePanelController * vc = [[JASidePanelController alloc] init];
    vc.leftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    HomeViewController * homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    AppDelegate *d = [[UIApplication sharedApplication] delegate];
    d.drawerView=vc;
    d.drawerView.panningLimitedToTopViewController=NO;
    d.drawerView.recognizesPanGesture=NO;
    d.drawerView.leftFixedWidth=self.view.frame.size.width/1.5;
    
    vc.centerPanel = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showHidePasswordClick:(id)sender {
    [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE] forState:UIControlStateNormal];

}

- (IBAction)forgetClick:(id)sender {
}

- (IBAction)signUpClick:(id)sender {
}
@end
