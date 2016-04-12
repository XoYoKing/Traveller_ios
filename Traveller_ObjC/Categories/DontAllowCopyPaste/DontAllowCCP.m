//
//  DontAllowCCP.m
//  BTCorporate
//
//  Created by Sagar Shirbhate on 16/06/15.
//  Copyright (c) 2015 Benchmark It Solutions. All rights reserved.
//

#import "DontAllowCCP.h"

@implementation DontAllowCCP

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return NO;
    
    if (action == @selector(copy:))
        return NO;
    
    if (action == @selector(selectAll:))
        return NO;
    
    if (action == @selector(cut:))
        return NO;
   

    return [super canPerformAction:nil withSender:sender];
}

@end
