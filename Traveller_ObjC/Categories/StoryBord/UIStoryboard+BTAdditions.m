//
//  UIStoryboard+BTAdditions.m
//  BTCorporate
//
//  Created by Sagar Shirbhate on 28/04/15.
//  Copyright (c) 2015 Benchmark It Solutions. All rights reserved.
//

#import "UIStoryboard+BTAdditions.h"

@implementation UIStoryboard (BTAdditions)
+ (instancetype)storyboardWithName:(NSString *)name
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *storyboardName = name ?: [bundle objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
    return [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
}
@end
