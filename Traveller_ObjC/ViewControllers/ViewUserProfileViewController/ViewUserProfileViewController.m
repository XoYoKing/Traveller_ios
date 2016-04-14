//
//  ViewUserProfileViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewUserProfileViewController.h"

@interface ViewUserProfileViewController ()

@end

@implementation ViewUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSend setFrame:CGRectMake(0, 0, 30, 30)];
    btnSend.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnSend.tintColor=[UIColor redColor];
   // [btnSend setTitle:[FontIcon iconString:ICON_SEND] forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendBarBtn = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    
    
    NSMutableArray *buttonArray=[[NSMutableArray alloc]initWithCapacity:2];
    [buttonArray addObject:sendBarBtn];
    self.navigationItem.rightBarButtonItems = buttonArray;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
