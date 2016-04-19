//
//  ForgetPasswordViewController.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 12/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
            [super viewDidLoad];
            [self setUpView];
}

-(void)setUpView{
    
            [alertBackView addWhiteLayerAndCornerRadius:8 AndWidth:1];
            [submitBtn addBlackLayerAndCornerRadius:3 AndWidth:1];
            [cancelBtn addBlackLayerAndCornerRadius:3 AndWidth:1];
            cancelBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
            submitBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
            [submitBtn setBackgroundColor:userShouldDOButoonColor];
            [cancelBtn setBackgroundColor:userShouldNOTDOButoonColor];
            titleLbl.font=[UIFont fontWithName:font_bold size:font_size_button];
            subTitleLbl.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
            [emailTF addRegx:@"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" withMsg:@"Enter valid email."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelClick:(id)sender{
       [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)submitClick:(id)sender{
            if ([emailTF validate]) {
                 [JTProgressHUD show];
                [self performSelectorInBackground:@selector(callForgetPassWebservice) withObject:nil];
            }
}


-(void)callForgetPassWebservice{
            NSString *strOfUrl = [NSString stringWithFormat:@"%@email=%@&action=%@",URL_CONST,emailTF.text,ACTION_FORGET_PASSWORD];
            NSDictionary * dict = [[WebHandler sharedHandler]getDataFromWebservice:strOfUrl];
            if (dict!=nil) {
                NSString * msg =[dict valueForKey:@"message"];
                [self performSelectorOnMainThread:@selector(showToastWithMessageForForget:) withObject:msg waitUntilDone:YES];
                
            }else{
                [self performSelectorOnMainThread:@selector(showToastWithMessage:) withObject:no_internet_message waitUntilDone:YES];
            }
}


-(void)showToastWithMessageForForget:(NSString*)msg{
            [JTProgressHUD hide];
            [self.view makeToast:msg duration:toastDuration position:toastPositionBottomUp];
            [self performSelector:@selector(cancelClick:) withObject:nil afterDelay:3];
}
@end
