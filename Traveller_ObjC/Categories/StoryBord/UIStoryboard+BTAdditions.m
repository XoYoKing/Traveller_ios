//
//  UIStoryboard+BTAdditions.m
//  BTCorporate
//
//  Created by Sagar Shirbhate on 28/04/15.
//  Copyright (c) 2015 Benchmark It Solutions. All rights reserved.
//

#import "UIStoryboard+BTAdditions.h"

@implementation UIStoryboard (BTAdditions)
+ (instancetype)storyboardMain
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *storyboardName = [bundle objectForInfoDictionaryKey:@"Storyboard"];
    return [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
}
@end
