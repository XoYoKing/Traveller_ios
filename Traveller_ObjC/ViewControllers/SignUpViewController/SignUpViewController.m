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
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"SignUp";
    [self setUpView];
    [self setUpNavigationBar];
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
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_KEY] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(changePassClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.rightBarButtonItem = right;
     }
    
}
-(void)changePassClick{
    ChangePasswordViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
    }else{
        updateBtn.hidden=YES;
        cancelBtn.hidden=YES;
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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
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

- (IBAction)updateClick:(id)sender {
}

- (IBAction)maleBtnClick:(id)sender {
    maleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    maleChk.text =[NSString stringWithUTF8String:ICOMOON_CHECK];
    maleChk.textColor=Check_Color;
    
    femaleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    femaleChk.text =[NSString stringWithUTF8String:ICOMOON_CROSS];
    femaleChk.textColor=Uncheck_Color;
}

- (IBAction)femaleClick:(id)sender {
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
}

- (IBAction)cancelClick:(id)sender {
}
@end
