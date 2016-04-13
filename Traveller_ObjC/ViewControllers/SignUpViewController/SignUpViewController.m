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
