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
