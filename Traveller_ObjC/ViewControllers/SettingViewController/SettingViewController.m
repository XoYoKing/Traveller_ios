//
//  SettingViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SettingViewController.h"
#import "SignUpViewController.h"
#import "ChangePasswordViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Settings";
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationCount:) name:throwNotificationStatus object:nil];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:font_bold size:font_size_normal_regular], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.backgroundColor=navigation_background_Color;
    self.navigationController.navigationBar.barTintColor=navigation_background_Color;
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

-(void)updateNotificationCount:(NSNotification *)notification{
    NSDictionary * dict =notification.object;
    int count = [[dict valueForKey:@"tip_count"] intValue];
    badgeView.badgeValue = count;
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

-(void)addNotificationView{
    UIButton *  notificationButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    notificationButton.frame = CGRectMake(self.view.frame.size.width-65,self.view.frame.size.height-65,50,50);
    notificationButton.titleLabel.font =[UIFont fontWithName:fontIcomoon size:25];
    notificationButton.titleLabel.textColor=[UIColor whiteColor];
    notificationButton.backgroundColor=[UIColor blackColor];
    notificationButton.layer.cornerRadius=25;
    [notificationButton setTitle:[NSString stringWithUTF8String:ICOMOON_BELL] forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(openNotificationView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBarHidden=NO;
    badgeView = [GIBadgeView new];
    [notificationButton addSubview:badgeView];
    badgeView.badgeValue = [UserData getNotificationCount];
    [self addShaddowToView:notificationButton];
    [self.view addSubview:notificationButton];
    [self.view bringSubviewToFront:notificationButton];
}
-(void)openNotificationView{
    NotificationsViewController* vc =[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    vc.fromMenu=NO;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)viewDidAppear:(BOOL)animated{
    if (badgeView==nil) {
        [self addNotificationView];
    }
    
    
    if ([self notificationServicesEnabled]) {
        pushNotificationSwitch.on=YES;
    }else{
        pushNotificationSwitch.on=NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushClick:(UISwitch *)sender {
    if (!sender.isOn) {
        [self showAlert:@"For turning OFF the notifications please turn switch OFF to stop recieving notifications from BTOnsite "];
    }else{
        [self showAlert:@"For turning ON the notifications please select allow notifications from BTOnsite and Switch on Sound, Badge & Alert"];
    }
}
-(void)showAlert:(NSString *)msg{
    
    if ([msg isEqualToString:@"For turning OFF the notification please turn switch OFF to stop recieving notification from BTOnsite "]) {
        pushNotificationSwitch.on=YES;
    }else{
        pushNotificationSwitch.on=NO;
    }
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Traweller"
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction* delete = [UIAlertAction
                             actionWithTitle:@"Setting"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view addAction:ok];
    [view addAction:delete];
    
    if (!iPAD) {
        [self presentViewController:view animated:YES completion:nil];
    }else {
        CGPoint windowPoint = [pushNotificationSwitch convertPoint:pushNotificationSwitch.bounds.origin toView:self.view.window];
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:view];
        [popup presentPopoverFromRect: CGRectMake(pushNotificationSwitch.frame.origin.x, windowPoint.y+15, pushNotificationSwitch.frame.size.width, pushNotificationSwitch.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
- (BOOL)notificationServicesEnabled {
    BOOL isEnabled = NO;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){
        UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (!notificationSettings || (notificationSettings.types == UIUserNotificationTypeNone)) {
            isEnabled = NO;
        } else {
            isEnabled = YES;
        }
    }
    return isEnabled;
}
- (IBAction)editClick:(UIButton *)sender{
    SignUpViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    vc.fromWhichMenu=@"Update";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)chengePasswordClick:(UIButton *)sender{
    ChangePasswordViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
