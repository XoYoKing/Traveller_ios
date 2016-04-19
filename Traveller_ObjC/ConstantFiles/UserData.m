//
//  UserData.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 11/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "UserData.h"

@implementation UserData

#pragma mark======================= Get File Path======================
+(NSString *)filePath
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"UserData.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    return path;
}


#pragma mark======================= Setter Methods======================

+(void ) setLogOutStatus{
    NSMutableDictionary * plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    [plistDict setObject:@"No"  forKey:@"UserLoggedIn"];
    [plistDict writeToFile:[self filePath] atomically:YES];
}

+(void )setIntroShown{
    NSMutableDictionary * plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    [plistDict setObject:@"Yes"  forKey:@"StartUpShown"];
    [plistDict writeToFile:[self filePath] atomically:YES];
}
+(void)saveUserDict :(NSDictionary *)fromServiceDict{
    NSMutableDictionary * plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    
    NSDictionary * userDict =[[NSDictionary alloc]initWithDictionary:[[fromServiceDict valueForKey:@"data"]lastObject]];
            [plistDict setObject: [userDict valueForKey:@"add_date"]   forKey:@"Created_On"];
            [plistDict setObject: [userDict valueForKey:@"city"]   forKey:@"City"];
            [plistDict setObject: [userDict valueForKey:@"country"]   forKey:@"Country"];
            [plistDict setObject:  [userDict valueForKey:@"email"]   forKey:@"Email"];
            [plistDict setObject: [userDict valueForKey:@"fb_id"]   forKey:@"Fb_id"];
            [plistDict setObject: [userDict valueForKey:@"gcm_regid"]   forKey:@"gcm_regid"];
            [plistDict setObject: [userDict valueForKey:@"gender"]   forKey:@"Gender"];
            [plistDict setObject: [userDict valueForKey:@"gp_id"]    forKey:@"Google_id"];
            [plistDict setObject: [userDict valueForKey:@"id"]   forKey:@"UserId"];
            [plistDict setObject: [userDict valueForKey:@"mobile"]   forKey:@"Mobile"];
            [plistDict setObject: [userDict valueForKey:@"my_status"]   forKey:@"My_status"];
            [plistDict setObject: [userDict valueForKey:@"name"]   forKey:@"Name"];
            [plistDict setObject: [userDict valueForKey:@"next_destination"]   forKey:@"Next_destination"];
            [plistDict setObject: [userDict valueForKey:@"password"]   forKey:@"Password"];
            [plistDict setObject: [userDict valueForKey:@"signupType"]   forKey:@"SignupType"];
            [plistDict setObject: [userDict valueForKey:@"state"]   forKey:@"State"];
            [plistDict setObject: [userDict valueForKey:@"status"]   forKey:@"Status"];
            [plistDict setObject: [userDict valueForKey:@"user_type"]   forKey:@"User_type"];
            [plistDict setObject: [userDict valueForKey:@"weburl"]   forKey:@"Weburl"];
            [plistDict setObject: [fromServiceDict valueForKey:@"image"]   forKey:@"ImageUrl"];
            [plistDict setObject: @"Yes" forKey:@"UserLoggedIn"];
    [plistDict writeToFile:[self filePath] atomically:YES];
  }


+(void) setNotificationCount :(int)count{
    NSMutableDictionary * plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    [plistDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"NotificationCount"];
    [plistDict writeToFile:[self filePath] atomically:YES];
}


+(void )setNotificationDict : (NSDictionary *) dict {
    NSMutableDictionary * plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePath]];
    [plistDict setObject:dict forKey:@"NotificationDict"];
    [plistDict writeToFile:[self filePath] atomically:YES];
}

#pragma mark======================= Getter Methods======================

+(NSDictionary *) getNotificationDict{
    NSDictionary * notificationDict =[NSDictionary new];
     NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    notificationDict=[dict valueForKey:@"NotificationDict"];
    return notificationDict;
}

+(int) getNotificationCount{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [[dict valueForKey:@"NotificationCount"] intValue];
}


+(NSString *) getUserID{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"UserId"];
}
+(NSString *) getUserCreated_On{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Created_On"];
}
+(NSString *) getUserCity{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"City"];
}
+(NSString *) getUserCountry{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Country"];
}
+(NSString *) getUserName{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Name"];
}
+(NSString *) getUserEmail{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Email"];
}
+(NSString *) getUserFb_id{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Fb_id"];
}
+(NSString *) getUsergcm_regid{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"gcm_regid"];
}
+(NSString *) getUserGender{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Gender"];
}
+(NSString *) getUserGoogle_id{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Google_id"];
}
+(NSString *) getUserMobile{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Mobile"];
}
+(NSString *) getUserMyStatus{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"My_status"];
}
+(NSString *) getUserDestimation{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"next_destination"];
}
+(NSString *) getUserPassword{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Password"];
}
+(NSString *) getUserSignupType{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"SignupType"];
}
+(NSString *) getUserStatus{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Status"];
}
+(NSString *) getUserState{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"State"];
}
+(NSString *) getUserWeburl{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"Weburl"];
}
+(NSString *) getUser_type{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"User_type"];
}
+(NSString *) getUserImageUrl{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"ImageUrl"];
}

+(NSString *) getUserLoginStatus{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"UserLoggedIn"];
}

+(NSString *) checkIntroViewShown{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: [self filePath]];
    return [dict valueForKey:@"StartUpShown"];
}


@end
