//
//  SplashScreenViewController.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
@interface SplashScreenViewController ()
{
    NSTimer * timer;
    float progress;
    IBOutlet UIProgressView *progressBar;
    IBOutlet UIImageView *image;
}
@end



@implementation SplashScreenViewController

#pragma mark+++++++++++++++++++View Controller Life Cycle+++++++++++++++++++++++

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    progress = 0 ;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.2
                                             target:self
                                           selector:@selector(targetMethod)
                                           userInfo:nil
                                            repeats:YES];
    progressBar.layer.cornerRadius=7;
    progressBar.clipsToBounds=YES;
   
#warning TO DO FOR PUSH NOTIFICATION
     if ([[UserData getUserLoginStatus]isEqualToString:@"Yes"]) {
         [self registerDeviceId];// Because every time token id changes
     }else{
          [self removeDeviceId]; // remove this device for particular user because only status changes but user data still in plist
     }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)targetMethod{
    progress =progress + 0.1;
    if (progress>=1.0) {
        [timer invalidate];
        [self pushLoginView];
    }else{
        progressBar.progress = progress;
    }
}


#pragma mark+++++++++++++++++++Open Login View or Home Page+++++++++++++++++++++++
-(void)pushLoginView{
    if ([[UserData getUserLoginStatus]isEqualToString:@"Yes"]) {
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
    }else{
        LoginViewController * loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark+++++++++++++++++++Call register Device Id Service Here+++++++++++++++++++++++


-(void)registerDeviceId{
#warning TO DO FOR PUSH NOTIFICATION
    [UserData getDeviceTokenId];
    // Pass Device Token id To server For push Notification and till responce come show Loader
}

#pragma mark+++++++++++++++++++Call Deregister Device Id Service Here+++++++++++++++++++++++

-(void)removeDeviceId{
#warning TO DO FOR PUSH NOTIFICATION
    [UserData getUserID];
    // just pass user id and remove token from server
    // Pass Device Token id To server For push Notification and till responce come show Loader
}


@end
