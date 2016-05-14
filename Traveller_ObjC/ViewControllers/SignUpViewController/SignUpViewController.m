//
//  SignUpViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SignUpViewController.h"
#import "TermsAndConditionViewController.h"
#import "ChangePasswordViewController.h"
#import "HomeViewController.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpNavigationBar];
    gender=@"0";
}
-(void)setUpNavigationBar{
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
    
     if ([_fromWhichMenu isEqualToString:@"Update"]) {
         
         
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [btn setFrame:CGRectMake(0, 0, 30, 30)];
         
         btn.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
         btn.tintColor=[UIColor whiteColor];
         
    [btn setTitle:[NSString stringWithUTF8String:ICOMOON_KEY] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changePassClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;
     }
    
}
-(void)changePassClick{
    ChangePasswordViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];SettingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    

}


-(void)setUpView{
    maleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    maleChk.text =[NSString stringWithUTF8String:ICOMOON_CHECK];
    maleChk.textColor=Check_Color;
    
    femaleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    femaleChk.text =[NSString stringWithUTF8String:ICOMOON_CROSS];
    femaleChk.textColor=Uncheck_Color;
    
    termButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [termButton setTitle:[NSString stringWithUTF8String:ICOMOON_RADIO_UNCHECK] forState:UIControlStateNormal] ;
    
    [countryTF setLeftPadding:35];
    
    countryPicker = [[CountryPicker alloc] init];
    countryPicker.delegate=self;
    countryTF.inputView = countryPicker;
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, self.view.frame.size.width, 44)]; //should code with variables to support view resizing
    myToolbar.backgroundColor=[UIColor whiteColor];
    
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(hidePicker)];
    UIBarButtonItem *flexibleWidth = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleWidth1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancleBtn =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                  target:self action:@selector(hidePicker)];
    [myToolbar setItems:[NSArray arrayWithObjects: cancleBtn,flexibleWidth,flexibleWidth1,doneButton, nil] animated:NO];
    // Add toolbars to textfields
    countryTF.inputAccessoryView = myToolbar;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:font_regular size:font_size_normal_regular]};
    termsLbl.attributedText = [[NSAttributedString alloc]initWithString:@"I accept Terms and Conditions" attributes:attributes];
    termsLbl.userInteractionEnabled=YES;
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
            TermsAndConditionViewController * vc= [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditionViewController"];
            [self.navigationController pushViewController:vc animated:YES];
    };
    //Added link substrings

        NSMutableArray * substringArr =[NSMutableArray new];
      [substringArr addObject:@"Terms and Conditions"];
        [termsLbl setLinksForSubstrings:substringArr withLinkHandler:handler];
    
    if ([_fromWhichMenu isEqualToString:@"Update"]) {
        registerBtn.hidden=YES;
        registerHeightConstraint.constant=-80;
        [self.view layoutIfNeeded];
        termsLbl.hidden=YES;
        termButton.hidden=YES;
        [self setValues];
        self.title=@"Update Profile";
        
        if ([[UserData getUserSignupType]isEqualToString:@"facebook"]||[[UserData getUserSignupType]isEqualToString:@"google"]) {
            userNameTF.userInteractionEnabled=NO;
            passwordTF.userInteractionEnabled=NO;
            emailTF.userInteractionEnabled=NO;
            confirmPasswordTF.userInteractionEnabled=NO;
            phoneNoTF.userInteractionEnabled=NO;
        }
        
    }else{
        updateBtn.hidden=YES;
        cancelBtn.hidden=YES;
        self.title=@"Sign Up";
    }
    
    statusTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     userNameTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     emailTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     passwordTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     websiteTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     nextDestinationTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     cityTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     confirmPasswordTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
     phoneNoTF.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
    maleLBL.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    femaleLBL.font=[UIFont fontWithName:font_bold size:font_size_normal_regular];
    registerBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    cancelBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    updateBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    
    [userNameTF addRegx:@"[a-zA-Z0-9]{3,30}" withMsg: @"Username characters limit should be come between 6-20"];
     [emailTF addRegx:@"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" withMsg: @"Enter valid email"];
     [passwordTF addRegx:@"^.{6,20}$" withMsg: @"Password characters limit should be come between 6-20"];
     [confirmPasswordTF addConfirmValidationTo:passwordTF withMsg:@"Confirm password didn’t match"];
     [phoneNoTF addRegx:@"[0-9]{5,20}" withMsg: @"Only numeric characters are allowed"];
    
}

-(void)setValues{
    statusTF.text=[UserData getUserMyStatus];
    userNameTF.text=[UserData getUserName];
    emailTF.text=[UserData getUserEmail];
    passwordTF.text=[UserData getUserPassword];
    websiteTF.text=[UserData getUserWeburl];
    
    nextDestinationTF.text=[UserData getUserDestimation];
    cityTF.text=[UserData getUserCity];
    confirmPasswordTF.text=[UserData getUserPassword];
    phoneNoTF.text=[UserData getUserMobile];
    countryTF.text=[UserData getUserCountry];
    passwordTF.userInteractionEnabled=NO;
    confirmPasswordTF.userInteractionEnabled=NO;
    emailTF.userInteractionEnabled=NO;
}

-(void)hidePicker{
    [self.view endEditing:YES];
}

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code{
    countryTF.text = name;
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", code];
    UIImage *image;
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)])
        image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:[CountryPicker class]] compatibleWithTraitCollection:nil];
    countryImageView.image=image;
}


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
      self.navigationController.navigationBarHidden=NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateClick:(id)sender {
    if ([[UserData getUserSignupType]isEqualToString:@"facebook"]||[[UserData getUserSignupType]isEqualToString:@"google"]){
        [self.view showLoader];
        [self performSelectorInBackground:@selector(updateWebservice) withObject:nil];
    }else{
    if ([userNameTF validate]&&[emailTF validate]&&[passwordTF validate]&&[confirmPasswordTF validate]) {
            [self.view showLoader];
            [self performSelectorInBackground:@selector(updateWebservice) withObject:nil];
    }
    }
}
-(void)updateWebservice{
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&name=%@&email=%@&mobile=%@&city=%@&country=%@&my_status=%@&weburl=%@&nextDestination=%@",URL_CONST,ACTION_UPDATE_PROFILE,userNameTF.text,emailTF.text,phoneNoTF.text,cityTF.text,countryTF.text,statusTF.text,websiteTF.text,nextDestinationTF.text];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
            [self performSelectorOnMainThread:@selector(updatedSuccessfully) withObject:nil waitUntilDone:YES];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
        }
    }else{
        NSString * msg =no_internet_message;
        [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
    }
}

-(void)updatedSuccessfully{
    

    SettingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    
      [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    

}


- (IBAction)maleBtnClick:(id)sender {
    maleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    maleChk.text =[NSString stringWithUTF8String:ICOMOON_CHECK];
    maleChk.textColor=Check_Color;
    
    femaleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    femaleChk.text =[NSString stringWithUTF8String:ICOMOON_CROSS];
    femaleChk.textColor=Uncheck_Color;
    gender=@"0";
}

- (IBAction)femaleClick:(id)sender {
        gender=@"1";
    maleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    maleChk.text =[NSString stringWithUTF8String:ICOMOON_CROSS];
    maleChk.textColor=Uncheck_Color;
    
    femaleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    femaleChk.text =[NSString stringWithUTF8String:ICOMOON_CHECK];
    femaleChk.textColor=Check_Color;
}

- (IBAction)termButtonClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:[NSString stringWithUTF8String:ICOMOON_RADIO_UNCHECK]]) {
        termButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
        [termButton setTitle:[NSString stringWithUTF8String:ICOMOON_RADIO_CHECK] forState:UIControlStateNormal] ;
    }else{
        termButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
        [termButton setTitle:[NSString stringWithUTF8String:ICOMOON_RADIO_UNCHECK] forState:UIControlStateNormal] ;
    }
}

- (IBAction)registerClick:(id)sender {
    [self.view endEditing:YES];
    if ([userNameTF validate]&&[emailTF validate]&&[passwordTF validate]&&[confirmPasswordTF validate]) {
        if ([termButton.titleLabel.text isEqualToString:[NSString stringWithUTF8String:ICOMOON_RADIO_UNCHECK]]) {
            [self showToast:@"Please accept tems and conditions"];
        }else{
            [self.view showLoader];
            [self performSelectorInBackground:@selector(registerWebservice) withObject:nil];
        }
    }
}


- (IBAction)cancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];SettingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)registerWebservice{
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&name=%@&email=%@&password=%@&mobile=%@&city=%@&country=%@&my_status=%@&weburl=%@&nextDestination=%@&gender=%@",URL_CONST,ACTION_SIGNUP,userNameTF.text,emailTF.text,passwordTF.text,phoneNoTF.text,cityTF.text,countryTF.text,statusTF.text,websiteTF.text,nextDestinationTF.text,gender];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            [self callLoginWebservice];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
        }
    }else{
        NSString * msg =no_internet_message;
        [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
    }
}

-(void)callLoginWebservice{
    NSString * str =[NSString stringWithFormat:@"%@email=%@&password=%@&action=%@",URL_CONST,userNameTF.text,passwordTF.text,ACTION_LOGIN];
    NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            [UserData saveUserDict:dict];
            [UserData setPassword:passwordTF.text];
            [self performSelectorOnMainThread:@selector(loginSuccessful) withObject:nil waitUntilDone:YES];
        }else{
            NSString * msg =[dict valueForKey:@"message"];
            [self performSelectorOnMainThread:@selector(showToast:) withObject:msg waitUntilDone:YES];
        }
    }else{
        [self performSelectorOnMainThread:@selector(showToast:) withObject:no_internet_message waitUntilDone:YES];
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
    if (iPAD) {
        d.drawerView.leftFixedWidth=self.view.frame.size.width/2;
    }else{
        d.drawerView.leftFixedWidth=self.view.frame.size.width/1.5;
    }
    
    vc.centerPanel = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)showToast:(NSString *)msg{
    [self.view hideLoader];
    [self.view makeToast:msg duration:toastDuration position:toastPositionBottomUp];
}



@end
