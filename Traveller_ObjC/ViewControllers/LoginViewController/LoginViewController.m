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


@interface LoginViewController ()

@end

@implementation LoginViewController
#pragma mark====================View Controller Life Cycles===============================

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];// To set up View Properly
}

#pragma mark====================Set Up View===============================

-(void)setUpView{
    // Check Whether its lower size or bigger size
    if (iPhone6||iPhone6plus||iPAD) {
        aboveConstraint.constant =100;
        [self.view layoutIfNeeded];
    }
    forgetPasswordBtn.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_button];
    needAnAccountBtn.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_button];
    usernameLogo.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    passwordLogo.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    showHidePasswordBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    loginButton.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    orLbl.font=[UIFont fontWithName:font_bold size:font_size_bold];
    googleBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    faceBookButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    usernameLogo.text =[NSString stringWithUTF8String:ICOMOON_USER];
    passwordLogo.text =[NSString stringWithUTF8String:ICOMOON_KEY];
    [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE_CLOSED] forState:UIControlStateNormal];
    [googleBtn setTitle:[NSString stringWithUTF8String:ICOMOON_GOOGLE] forState:UIControlStateNormal];
    [faceBookButton setTitle:[NSString stringWithUTF8String:ICOMOON_FACEBOOK] forState:UIControlStateNormal];
    [userNameTextField setLeftPadding:leftPadding];
    [passwordTextField setLeftPadding:leftPadding];
     [passwordTextField setRightPadding:leftPadding];
    [loginButton addBlackLayerAndCornerRadius:cornerRadius_Button AndWidth:borderWidth_Button];
    [loginButton addShaddow];
    [userNameTextField addRegx:@"^.{3,30}$" withMsg:@"User name charaters limit should be come between 3-30"];
    [passwordTextField addRegx:@"[A-Za-z0-9]{6,20}" withMsg:@"Password must be alpha numeric"];
    
}


#pragma mark====================Login With Facebook===============================

- (IBAction)facebookClick:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [self getUserInformation];
         }
     }];
}

-(void)getUserInformation
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"picture,email,first_name,last_name,location,birthday"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
         if (!error) {
             NSDictionary * dict = @{
                                     @"name":[NSString stringWithFormat:@"%@ %@",[result valueForKey:@"first_name"],[result valueForKey:@"last_name"]],
                                      @"fb_id":[result valueForKey:@"id"],
                                        @"email":[result valueForKey:@"email"]
                                     };
             [self loginForFacebook:dict];
         }
         else
         {
             NSLog(@"Failed to get Data: %@", [error localizedDescription]);
         }
     }];
}
// its in developement phase
-(void)loginForFacebook:(NSDictionary*)FBDict{
    NSString * name=[FBDict valueForKey:@"name"];
    NSString * email=[FBDict valueForKey:@"email"];
    NSString * fb_id=[FBDict valueForKey:@"fb_id"];
    NSString * str =[NSString stringWithFormat:@"%@name=%@&email=%@&password=&mobile=&city=&country=&state=&action=%@&signupType=facebook&fb_id=%@",URL_CONST,name,email,fb_id,SIGNUP_ACTION];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:msg waitUntilDone:YES];
        }
    }else{
        [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:no_internet_message waitUntilDone:YES];
    }
}

#pragma mark====================Login With Google===============================

- (IBAction)googleClick:(id)sender {
    
}


#pragma mark====================Login With Email===============================
- (IBAction)loginClick:(id)sender {
    
#if DEBUG
    userNameTextField.text=@"satishsolan7@gmail.com";
    passwordTextField.text=@"234";

    
   // if ([userNameTextField validate]&&[passwordTextField validate]) {
            [JTProgressHUD show];
           [self performSelectorInBackground:@selector(callLoginWebservice) withObject:nil];
//    }
  #endif
 
}

-(void)callLoginWebservice{
    NSString * str =[NSString stringWithFormat:@"%@email=%@&password=%@&action=%@",URL_CONST,userNameTextField.text,passwordTextField.text,LOGIN_ACTION];
   NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        
        if ( [status isEqual: SUCESS]) {
            
            NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:dict forKey:user_Data];
            [defaults synchronize];
              [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:msg waitUntilDone:YES];
        }
    }else{
        [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:no_internet_message waitUntilDone:YES];
    }
}


#pragma mark====================Open Home Page===============================

-(void)loginSuccessful{
      [JTProgressHUD hide];
    
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


#pragma mark====================Show Hide Password===============================

- (IBAction)showHidePasswordClick:(id)sender {
    if( passwordTextField.secureTextEntry==YES){
        passwordTextField.secureTextEntry=NO;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE] forState:UIControlStateNormal];
    }else{
        passwordTextField.secureTextEntry=YES;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE_CLOSED] forState:UIControlStateNormal];
    }
}


#pragma mark====================Forget Password Click===============================

- (IBAction)forgetClick:(id)sender {
    
}

#pragma mark====================SinUp Click===============================

- (IBAction)signUpClick:(id)sender {
    
    
}











@end
