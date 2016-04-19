//
//  UserData.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 11/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

+(NSString *)filePath;

+(void)saveUserDict :(NSDictionary *)fromServiceDict ;

+(NSString *) getUserID;

+(NSString *) getUserCreated_On;

+(NSString *) getUserCity;

+(NSString *) getUserCountry;

+(NSString *) getUserEmail;

+(NSString *) getUserName;

+(NSString *) getUserFb_id;

+(NSString *) getUsergcm_regid;

+(NSString *) getUserGender;

+(NSString *) getUserGoogle_id;

+(NSString *) getUserMobile;

+(NSString *) getUserMyStatus;

+(NSString *) getUserDestimation;

+(NSString *) getUserPassword;

+(NSString *) getUserSignupType;

+(NSString *) getUserStatus;

+(NSString *) getUserState;

+(NSString *) getUserWeburl;

+(NSString *) getUser_type;

+(NSString *) getUserImageUrl;

+(NSString *) getUserLoginStatus;

+(NSString *) checkIntroViewShown;

+(int) getNotificationCount;

+(void) setNotificationCount :(int)count ;

+(NSDictionary *) getNotificationDict;

+(void )setNotificationDict : (NSDictionary *) dict ;

+(void )setIntroShown;

+(void ) setLogOutStatus;
@end
