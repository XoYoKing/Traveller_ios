//
//  AppDelegate.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 06/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "HomeViewController.h"
#import "RFRateMe.h"
#import "UIAlertView+NSCookbook.h"
@interface AppDelegate ()<GPPSignInDelegate>

@end

@implementation AppDelegate

#pragma mark = didFinishLaunchingWithOptions
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    //For Facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    // For Google+
    [[GPPSignIn sharedInstance] setClientID:@"748214312326-57qjoec3g5762tlcktag90cha9ngj6be.apps.googleusercontent.com"];
    [GPPSignIn sharedInstance].delegate = self;
    [GMSServices provideAPIKey:@"AIzaSyA0Zxe_1JxR0Iemvi8RLel0ZEzWEBNPfqM"];

    // For Notifications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
    
    
    //Option 1 (Show the alert)
    [RFRateMe showRateAlert];
    
    // Option 2 (Show the alert after X amount of times you opened the app)
    [RFRateMe showRateAlertAfterTimesOpened:3];
    
    // Option 3 (Show the alert after X amount of days you opened the app for the first time)
    [RFRateMe showRateAlertAfterDays:7];
    
    
    return YES;
}

#pragma mark push notification methods
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    // Prepare the Device Token for Registration (remove spaces and < >)
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"My token is: %@", devToken);
    
    NSError*error;
    NSString *stringToWrite = devToken;
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"myfile.txt"];
    [stringToWrite writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}
-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error

{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
}

#pragma mark = openURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
#ifdef DEBUG
    NSLog(@"%@",url.scheme);
#endif
    
    // Url Scheme for Google
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation] ||[[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
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

#pragma mark = google+ delegate Method
-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
}

@end
