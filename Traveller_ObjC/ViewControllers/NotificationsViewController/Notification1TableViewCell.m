//
//  Notification1TableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "Notification1TableViewCell.h"
#import "TravellerConstants.h"
@implementation Notification1TableViewCell




-(void)awakeFromNib{
        _bgView.layer.borderColor=[UIColor blackColor].CGColor;
        _bgView.layer.borderWidth=1;
        _bgView.layer.cornerRadius=6;
        [self addShaddowToView:_bgView];
    
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
