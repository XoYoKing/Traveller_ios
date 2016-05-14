//
//  WriteMessage ViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 23/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "WriteMessage ViewController.h"

@interface WriteMessage_ViewController ()

@end

@implementation WriteMessage_ViewController
-(void)setUpNavigationBar{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setFrame:CGRectMake(0, 0, 30, 30)];
    
    btnClose.titleLabel.font=[UIFont fontWithName:fontIcomoon size:logo_Size_Small];
    btnClose.tintColor=back_btn_Color;
    [btnClose setTitle:[NSString stringWithUTF8String:ICOMOON_BACK_CIECLE_LEFT] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = leftbarButton;
}


-(void)hideKeybord{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeybord)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    self.title=@"Send Message";
    [self setUpNavigationBar];
    _descriptionTextView.layer.borderWidth=1;
    _descriptionTextView.layer.cornerRadius=5;
    _descriptionTextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning { 
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendButtonClick:(id)sender {
    [self.view endEditing:YES];
    if (_descriptionTextView.text.length<=2) {
        [self.view makeToast:@"Please enter some message" duration:toastDuration position:toastPositionBottomUp];
    }else{
        [self.view showLoader];
        [self performSelectorInBackground:@selector(messageWebservice) withObject:nil];
    }
}
-(void)messageWebservice{
    NSString * userID =[UserData getUserID];
    NSString * str =[NSString stringWithFormat:@"%@&action=%@&userId=%@&publicId=%@&type=message&message=%@&type=phone_message",URL_CONST,ACTION_NOTIFICATION_REPLY,userID,_publicId,_descriptionTextView.text];
 NSDictionary * dict =  [[WebHandler sharedHandler]getDataFromWebservice:str];
    if (dict!=nil) {
        NSNumber *status = [NSNumber numberWithInteger:[[dict valueForKey:@"status"] intValue] ] ;
        if ( [status isEqual: SUCESS]) {
            [self performSelectorOnMainThread:@selector(sucess) withObject:nil waitUntilDone:YES];
        }else{
            [self performSelectorOnMainThread:@selector(error) withObject:nil waitUntilDone:YES];
        }
    }else{
         [self performSelectorOnMainThread:@selector(error) withObject:nil waitUntilDone:YES];
    }
}
-(void)sucess{
    [self.view hideLoader];
      [self.view makeToast:@"Message Sent Successfully" duration:toastDuration position:toastPositionBottomUp];
    [self performSelector:@selector(backClick) withObject:nil afterDelay:2];

}
-(void)error{
    [self.view hideLoader];
      [self.view makeToast:@"Error comes while sending message.Please try again" duration:toastDuration position:toastPositionBottomUp];
    [self performSelector:@selector(backClick) withObject:nil afterDelay:2];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
