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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    progress = 0 ;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.2
                                             target:self
                                           selector:@selector(targetMethod)
                                           userInfo:nil
                                            repeats:YES];
    image.layer.shadowOffset = CGSizeMake(1, 1);
    image.layer.shadowColor = [[UIColor blackColor] CGColor];
    image.layer.shadowRadius = 4.0f;
    image.layer.shadowOpacity = 0.80f;
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


-(void)pushLoginView{
    
    if ([[UserData getUserLoginStatus]isEqualToString:@"Yes"]) {
        JASidePanelController * vc = [[JASidePanelController alloc] init];
        vc.leftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        HomeViewController * homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        AppDelegate *d = [[UIApplication sharedApplication] delegate];
        d.drawerView=vc;
        d.drawerView.panningLimitedToTopViewController=NO;
        d.drawerView.recognizesPanGesture=NO;
        d.drawerView.leftFixedWidth=self.view.frame.size.width/1.5;
        vc.centerPanel = [[UINavigationController alloc] initWithRootViewController:homeVc];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController * loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
