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


-(void)sendFile:(NSString *)filePath toURL:(NSURL *)url withParameters:(NSDictionary *)params completion:(requestCompletionBlock)completionBlock
{
    if ([self connected])
    {
        NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
        // configure the request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        // set content type
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        //create body
        request.HTTPBody = [self createBodyWithParameters:params paths:@[filePath] boundary:boundary];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSError *error;
            NSDictionary* responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&error];
            completionBlock(response,responseJSON,error);
        }];
        
    }
    
}
- (NSData *)createBodyWithParameters:(NSDictionary *)parameters paths:(NSArray *)paths boundary:(NSString *)boundary
{
    
    
    NSMutableData *httpBody = [[NSMutableData alloc] init];
    
    // add params (all params are strings)
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop)
     {
         [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
         [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
         [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
     }];
    // add image data
    for (NSString *path in paths)
    {
        NSString *filename  = [path lastPathComponent];
        NSData   *data      = [[NSData alloc] initWithContentsOfFile:path options:NSDataReadingUncached error:nil];
        NSString *mimetype  = @"png";
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        filename =nil;
    }
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}

+(NSString *)mimeTypeForPath:(NSString *)path
{
    // get a mime type for an extension using MobileCoreServices.framework
    
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
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


@end
