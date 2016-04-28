//
//  ChangePasswordViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 20/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    lbl1.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    lbl2.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    lbl3.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    oldPass.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
    newPass.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
    confirmNewPass.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
    
    TextFieldValidator * demo =[[TextFieldValidator alloc]init];
    demo.text=[UserData getUserPassword];
    [oldPass addConfirmValidationTo:demo withMsg:@"Password didn’t match."];
    [newPass addRegx:@"[A-Za-z0-9]{6,20}" withMsg:@"Password must contain alpha numeric characters."];
    [confirmNewPass addConfirmValidationTo:newPass withMsg:@"Confirm password didn’t match."];
    [self setUpNavigationBar];
    self.title=@"Change Password";
    [self checkSignUpType];
}

-(void)setUpNavigationBar{
    self.navigationController.navigationBarHidden=NO;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=[UIColor whiteColor];
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
    
    UIButton *pwdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pwdBtn setFrame:CGRectMake(0, 0, 30, 30)];
    pwdBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    pwdBtn.tintColor=[UIColor whiteColor];
    pwdBtn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    pwdBtn.tintColor=[UIColor whiteColor];
    [pwdBtn setTitle:[NSString stringWithUTF8String:ICOMOON_RADIO_CHECK] forState:UIControlStateNormal];
    [pwdBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:pwdBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

-(void)checkSignUpType{
    if ([[UserData getUserSignupType]isEqualToString:@"facebook"]||[[UserData getUserSignupType]isEqualToString:@"google"]) {
         [self.view makeToast:@"You have been login via Facebook/Google you have no access change password" duration:toastDuration position:toastPositionBottomUp];
        [self performSelector:@selector(backClick) withObject:nil afterDelay:2];
    }
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveClick{
    if ([oldPass validate]&&[newPass validate]&&[confirmNewPass validate]) {
        [self.view showLoader];
        [self performSelectorInBackground:@selector(changePassWebservice) withObject:nil];
    }
}
-(void)changePassWebservice{
    NSString * str =[NSString stringWithFormat:@"%@action=%@&userId=%@&oldpassword=%@&password=%@&cpassword=%@",URL_CONST,ACTION_CHANGE_PASSWORD,[UserData getUserID],oldPass.text,newPass.text,confirmNewPass.text];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
                [UserData setPassword:newPass.text];
                [self performSelectorOnMainThread:@selector(showSuccessMsg) withObject:nil waitUntilDone:YES];
        }else{
            [self performSelectorOnMainThread:@selector(showErrorMsg) withObject:nil waitUntilDone:YES];
        }
    }else{
            [self performSelectorOnMainThread:@selector(showErrorMsg) withObject:nil waitUntilDone:YES];
    }
}

-(void)showSuccessMsg{
    [self.view hideLoader];
    [self.view makeToast:@"Password Change Successfully" duration:toastDuration position:toastPositionBottomUp];
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)showErrorMsg{
     [self.view hideLoader];
     [self.view makeToast:@"Password Didn't Change Successfully Please Try Again" duration:toastDuration position:toastPositionBottomUp];
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

@end
