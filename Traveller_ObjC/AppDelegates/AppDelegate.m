//
//  AppDelegate.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 06/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "AppDelegate.h"
#import <Google/SignIn.h>
#import "HomeViewController.h"

@interface AppDelegate ()<GIDSignInDelegate>

@end

@implementation AppDelegate

#pragma mark = didFinishLaunchingWithOptions
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    //For Facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // For Google+
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    [GMSServices provideAPIKey:@"AIzaSyA0Zxe_1JxR0Iemvi8RLel0ZEzWEBNPfqM"];

    // For Notifications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
    
    return YES;
}

#pragma mark push notification methods
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"My token is: %@", devToken);
    [UserData setDeviceTokenId:devToken];
    
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"dev Token "message:[NSString stringWithFormat:@"%@",devToken] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
}
-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error

{
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark ++++++++++++++++  Push Notification Dictionary will come Here++++++++++++++
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
  if ([[UserData getUserLoginStatus]isEqualToString:@"Yes"]) {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    JASidePanelController * vc = [[JASidePanelController alloc] init];
    UIStoryboard * main =[UIStoryboard storyboardMain];
    vc.leftPanel = [main instantiateViewControllerWithIdentifier:@"MenuViewController"];
    NotificationsViewController * homeVc = [main instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    homeVc.fromMenu=YES;
    _drawerView=vc;
    _drawerView.panningLimitedToTopViewController=NO;
    _drawerView.recognizesPanGesture=NO;
    if (iPAD) {
        _drawerView.leftFixedWidth=self.window.frame.size.width/2;
    }else{
        _drawerView.leftFixedWidth=self.window.frame.size.width/1.5;
    }
    vc.centerPanel = [[UINavigationController alloc] initWithRootViewController:homeVc];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=nav;
  }
}


#pragma mark Google Sign in APIs
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    NSDictionary * dict =@{@"GoogleData":user};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"google" object:dict];
    
}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
}

#pragma mark = openURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
#ifdef DEBUG
    NSLog(@"%@",url.scheme);
#endif
    // Url Scheme for Google
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
    
       // Url Scheme for Facebook
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

#pragma mark = applicationWillResignActive
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark = applicationDidEnterBackground
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

#pragma mark = applicationWillEnterForeground
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark = applicationDidBecomeActive
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [FBSDKAppEvents activateApp];
    
}

#pragma mark = applicationWillTerminate
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
