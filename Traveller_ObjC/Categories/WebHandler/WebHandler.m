//
//  WebHandler.m
//
//  Created by Sagar Shirbhate on 22/04/15.
//  Copyright (c) xxxxx. All rights reserved.
//

#import "WebHandler.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"
@implementation WebHandler

#pragma mark call url

+(id)sharedHandler
{
    static dispatch_once_t token;
    static id sharedObject;
    dispatch_once(&token, ^{
        sharedObject =[[self alloc] init];
    });
    return sharedObject;
}
-(id)init
{
    return self;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


-(NSDictionary *)getDataFromWebservice:(NSString *)urlString{
    
    if ([self connected]) {
    NSURL * url =[NSURL URLWithString:urlString];
        if (url==nil) {
            return nil;
        }
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSError *e = nil;
        if (data!=nil) {
               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
             return dict;
        }else{
            return nil;
        }

       
    }else{
        return nil;
    }
}

-(BOOL)uploadDataWithImage:(UIImage *)image forKey:(NSString *)key andParameters:(NSDictionary *)dict OnUrl:(NSString *)url completion:(void(^)(NSDictionary *dict ))completionBlock{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    // add hidden parameter here
    NSDictionary * parameters = dict;
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // add image date here
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:key fileName:@"Imagefile.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data = (NSData *)responseObject;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:nil];
        completionBlock(json);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      completionBlock(nil);
    }];
    return YES;
}



@end
