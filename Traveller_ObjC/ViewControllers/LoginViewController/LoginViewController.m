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
#import "Toast+UIView.h"
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
     [passwordTextField setRightPadding:35];
    loginButton.layer.borderColor=[UIColor blackColor].CGColor;
    loginButton.layer.borderWidth=1;
    loginButton.layer.cornerRadius=4;
    [self addShaddowToView:loginButton];
    
    [userNameTextField addRegx:@"^.{3,30}$" withMsg:@"User name charaters limit should be come between 3-30"];
    [passwordTextField addRegx:@"[A-Za-z0-9]{6,20}" withMsg:@"Password must be alpha numeric"];

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


- (IBAction)googleClick:(id)sender {
}

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
        
        NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:dict forKey:@"UserDict"];
        [defaults synchronize];
        
        if ( [status isEqual: SUCESS]) {
            
            
              [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(errorAlert:) withObject:msg waitUntilDone:YES];
        }
    }else{
        [self performSelectorOnMainThread:@selector(errorAlert:) withObject:NO_INTERNET_MESSAGE waitUntilDone:YES];
    }
}


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

- (IBAction)showHidePasswordClick:(id)sender {
    if( passwordTextField.secureTextEntry==YES){
        passwordTextField.secureTextEntry=NO;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE] forState:UIControlStateNormal];
    }else{
        passwordTextField.secureTextEntry=YES;
            [showHidePasswordBtn setTitle:[NSString stringWithUTF8String:ICOMOON_EYE_CLOSED] forState:UIControlStateNormal];
    }
}

- (IBAction)forgetClick:(id)sender {
    
    
}

- (IBAction)signUpClick:(id)sender {
    
    
}





-(void)errorAlert:(NSString*)msg{
    [JTProgressHUD hide];
    [self.view makeToast:msg duration:toastDuration position:toastPositionBottomUp];
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
            [self performSelectorOnMainThread:@selector(errorAlert:) withObject:msg waitUntilDone:YES];
        }
    }else{
        [self performSelectorOnMainThread:@selector(errorAlert:) withObject:NO_INTERNET_MESSAGE waitUntilDone:YES];
    }

}


@end
