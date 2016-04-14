//
//  AppDelegate.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 06/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "JASidePanelController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JASidePanelController *drawerView;
@end

