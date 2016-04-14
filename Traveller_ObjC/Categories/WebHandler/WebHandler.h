//
//  WebHandler.h
//
//  Created by Sagar Shirbhate on 22/04/15.
//  Copyright (c) Sagar Shirbhate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>


@interface WebHandler : NSObject
+(id)sharedHandler;
-(NSDictionary *)getDataFromWebservice:(NSString *)urlString;
-(BOOL)uploadDataWithImage:(UIImage *)image forKey:(NSString *)key andParameters:(NSDictionary *)dict OnUrl:(NSString *)url completion:(void(^)(NSDictionary *dict))completionBlock;
@end
