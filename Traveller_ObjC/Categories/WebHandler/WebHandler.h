//
//  WebHandler.h
//
//  Created by Sagar Shirbhate on 22/04/15.
//  Copyright (c) xxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

typedef void (^requestCompletionBlock)(NSURLResponse *response, NSDictionary *jsonData, NSError *error);
@interface WebHandler : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLSessionDelegate>

@property(nonatomic,strong) NSMutableDictionary *paramsDictionary;

+(id)sharedHandler;

-(void)sendFile:(NSString *)filePath toURL:(NSURL *)url withParameters:(NSDictionary *)params completion:(requestCompletionBlock)completionBlock;

-(NSDictionary *)getDataFromWebservice:(NSString *)urlString;

@end
