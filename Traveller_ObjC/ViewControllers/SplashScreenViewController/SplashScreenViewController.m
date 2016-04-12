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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)upload {
    
    // !!! only JPG, PNG not covered! Have to cover PNG as well
    NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
    // NSLog(@"FileName == %@", fileName);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{
                                 @"name": @"Sagar Post",
                                 @"email": @"sagarpost@ymail.com",
                                 @"password": @"2ertereere",
                                 @"action": @"signUp",
                                 };
    // BASIC AUTH (if you need):
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  //  [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"foo" password:@"bar"];
    // BASIC AUTH END
    
    NSString *URLString = URL_CONST;
    
    /// !!! only jpg, have to cover png as well
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"avatar.jpg"], 0.5); // image size ca. 50 KB
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure %@, %@", error, operation.responseString);
    }];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
