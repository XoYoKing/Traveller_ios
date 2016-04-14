//
//  SignUpViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"SignUp";
    // Do any additional setup after loading the view.
    [self setUpView];
    [self setUpNavigationBar];
}
-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:22], NSFontAttributeName,
                                back_btn_Color, NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=back_btn_Color;
    //  [btnClose setTitle:[FontIcon iconString:ICON_CANCEL] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setUpView{
    maleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    maleChk.text =[NSString stringWithUTF8String:ICOMOON_CHECK];
    
    femaleChk.font=[UIFont fontWithName:fontIcomoon size:20];
    femaleChk.text =[NSString stringWithUTF8String:ICOMOON_UNCHECK];
    
    termButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [termButton setTitle:[NSString stringWithUTF8String:ICOMOON_CHECKBOX_UNCHECKED] forState:UIControlStateNormal] ;
    
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
}

- (IBAction)femaleClick:(id)sender {
}

- (IBAction)termButtonClick:(id)sender {
}

- (IBAction)registerClick:(id)sender {
}

- (IBAction)cancelClick:(id)sender {
}
@end
