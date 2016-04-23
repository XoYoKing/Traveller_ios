//
//  TermsAndConditionViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 18/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "TermsAndConditionViewController.h"

@interface TermsAndConditionViewController ()

@end

@implementation TermsAndConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    [self setUpNavigationBar];
    self.title=@"Terms And Conditions";
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
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
