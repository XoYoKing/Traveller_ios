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
#import "ForgetPasswordViewController.h"
#import "SignUpViewController.h"
#import <Google/SignIn.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
#pragma mark====================View Controller Life Cycles===============================

- (void)viewDidLoad {
    [super viewDidLoad];

    //For Intro View
    if ([[UserData checkIntroViewShown]isEqualToString:@"No"]) {
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor colorWithWhite:0.149 alpha:1.000];
        [self.view addSubview:self.introView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callLoginWithGoogle:) name:@"google" object:nil];
    [self setUpView];// To set up View Properly
    
       [GIDSignIn sharedInstance].uiDelegate = self;
}


#pragma mark====================Set Up View===============================

-(void)setUpView{
    // Check Whether its lower size or bigger size
    if (iPhone6||iPhone6plus||iPAD) {
        aboveConstraint.constant =100;
        if(iPAD){
            aboveConstraint.constant =200;
        }
        [self.view layoutIfNeeded];
    }
    forgetPasswordBtn.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_LoginButtons];
    needAnAccountBtn.titleLabel.font=[UIFont fontWithName:font_bold size:font_size_LoginButtons];
    usernameLogo.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    passwordLogo.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    showHidePasswordBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    loginButton.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    orLbl.font=[UIFont fontWithName:font_bold size:font_size_bold];
    googleBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    faceBookButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:50];
    usernameLogo.text =[NSString stringWithUTF8String:ICOMOON_ACCOUNT_CIRCLE];
    passwordLogo.text =[NSString stringWithUTF8String:ICOMOON_KEY];
    [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYECLOSE] forState:UIControlStateNormal];
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
                                        @"email":[result valueForKey:@"email"],
                                     @"image":[NSString stringWithFormat:@"http://graph.facebook.com/\%@/picture?type=large",[result valueForKey:@"id"]]
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
    fbdict=FBDict;
    [self performSelectorInBackground:@selector(facebookwebservice) withObject:nil];
    }

-(void)facebookwebservice{
    NSString * name=[fbdict valueForKey:@"name"];
    NSString * email=[fbdict valueForKey:@"email"];
    NSString * fb_id=[fbdict valueForKey:@"fb_id"];
    NSString * image = [fbdict valueForKey:@"image"];
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&name=%@&email=%@&fb_id=%@&signupType=facebook",URL_CONST,ACTION_SIGNUP,name,email,fb_id];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSDictionary * data =@{
                               @"name":name,
                               @"signupType":@"facebook",
                               @"user_type":@"facebook",
                               @"email":email,
                               @"fb_id":fb_id,
                               @"id":[dict valueForKey:@"mid"],
                               @"add_date" : @"",
                               @"city" : @"pune to",
                               @"country": @"",
                               @"gcm_regid" :@"",
                               @"gender" : @"0",
                               @"gp_id" : @"",
                               @"mobile" : @"",
                               @"my_status" : @"",
                               @"next_destination" : @"",
                               @"state" : @"",
                               @"status" : @"0",
                               @"weburl" : @"",
                               @"password":@""
                               };
        NSDictionary * main=  @{
                                @"data":@[data],
                                @"image":image
                                };
        
        [UserData saveUserDict:main];
        [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        
    }else{
        [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:no_internet_message waitUntilDone:YES];
    }

}


#pragma mark====================Login With Google===============================

- (IBAction)googleClick:(id)sender {
  [[GIDSignIn sharedInstance] signIn];
}

-(void)callLoginWithGoogle:(NSNotification *)notification{
    NSDictionary * dict =notification.object;
    GIDGoogleUser * user =[dict valueForKey:@"GoogleData"];
    NSString * name=(NSString *)user.profile.name;
    NSString * googleId=(NSString *)user.userID;
    NSString * emailId=(NSString *)user.profile.email;
    NSURL *url = [user.profile imageURLWithDimension:300];
    
    googleDict=@{
                 @"name": name,
                 @"googleId":googleId,
                 @"email":emailId,
                 @"image":url
                 };
    if (googleDict) {
        [self.view showLoader];
        [self performSelectorInBackground:@selector(googlewebservice) withObject:nil];
    }
}

-(void)googlewebservice{
    NSString * name=[googleDict valueForKey:@"name"];
    NSString * email=[googleDict valueForKey:@"email"];
    NSString * fb_id=[googleDict valueForKey:@"googleId"];
    NSString * image = [googleDict valueForKey:@"image"];
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&name=%@&email=%@&fb_id=%@&signupType=google",URL_CONST,ACTION_SIGNUP,name,email,fb_id];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSDictionary * data =@{
                               @"name":name,
                               @"signupType":@"google",
                               @"user_type":@"google",
                               @"email":email,
                               @"fb_id":fb_id,
                               @"id":[dict valueForKey:@"mid"],
                               @"add_date" : @"",
                               @"city" : @"",
                               @"country": @"",
                               @"gcm_regid" :@"",
                               @"gender" : @"0",
                               @"gp_id" : @"",
                               @"mobile" : @"",
                               @"my_status" : @"",
                               @"next_destination" : @"",
                               @"state" : @"",
                               @"status" : @"0",
                               @"weburl" : @"",
                               @"password":@""
                               };
        NSDictionary * main=  @{
                                @"data":@[data],
                                @"image":[NSString stringWithFormat:@"%@",image]
                                };
        
        [UserData saveUserDict:main];
        [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        
    }else{
        [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:no_internet_message waitUntilDone:YES];
    }
}

#pragma mark====================Login With Email===============================

- (IBAction)loginClick:(id)sender {
    [self.view endEditing:YES];
    
#if DEBUG
    userNameTextField.text=@"sagar@gmail.com";
    passwordTextField.text=@"sagar123";
  #endif

    
    if ([userNameTextField validate]&&[passwordTextField validate]) {
        [self.view showLoader];
        [self performSelectorInBackground:@selector(callLoginWebservice) withObject:nil];
    }
    
}

-(void)callLoginWebservice{
    NSString * str =[NSString stringWithFormat:@"%@email=%@&password=%@&action=%@",URL_CONST,userNameTextField.text,passwordTextField.text,ACTION_LOGIN];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            [UserData saveUserDict:dict];
            [UserData setPassword:passwordTextField.text];
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
    
    [self registerDeviceId]; // register Device token
    
      [JTProgressHUD hide];
    JASidePanelController * vc = [[JASidePanelController alloc] init];
    vc.leftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    HomeViewController * homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    AppDelegate *d = [[UIApplication sharedApplication] delegate];
    d.drawerView=vc;
    d.drawerView.panningLimitedToTopViewController=NO;
    d.drawerView.recognizesPanGesture=NO;
    if (iPAD) {
        d.drawerView.leftFixedWidth=self.view.frame.size.width/2;
    }else{
        d.drawerView.leftFixedWidth=self.view.frame.size.width/1.5;
    }
    
    vc.centerPanel = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark====================Show Hide Password===============================


- (IBAction)showHidePasswordClick:(id)sender {
    if( passwordTextField.secureTextEntry==YES){
        passwordTextField.secureTextEntry=NO;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYEOPEN] forState:UIControlStateNormal];
    }else{
        passwordTextField.secureTextEntry=YES;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYECLOSE] forState:UIControlStateNormal];
    }
}


#pragma mark====================Forget Password Click===============================


- (IBAction)forgetClick:(id)sender {
    
    ForgetPasswordViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordViewController"];
    [self setPresentationStyleForSelfController:self presentingController:newVC];
    [self presentViewController:newVC animated:YES completion:nil];

}

- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    presentingController.providesPresentationContextTransitionStyle = YES;
    presentingController.definesPresentationContext = YES;
    [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}

#pragma mark====================Sign Up Click===============================

- (IBAction)signUpClick:(id)sender {
    SignUpViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - ++++++++++++++++++ Start up View ++++++++++++++++++++++++++


-(void)onDoneButtonPressed{
    [UserData setIntroShown];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}


#pragma mark +++++++++++++++++++Show Toast Message Method +++++++++++++++++++

-(void)showToastWithMessage:(NSString *)msg{
     [self.view hideLoader];
    [self.view makeToast:msg duration:toastDuration position:toastPositionBottomUp];
}

#pragma mark+++++++++++++++++++Call register Device Id Service Here+++++++++++++++++++++++

-(void)registerDeviceId{
#warning TO DO FOR PUSH NOTIFICATION
    // Pass Device Token id To server For push Notification and till responce come show Loader
}


@end
