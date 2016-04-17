//
//  Notification4TableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "Notification4TableViewCell.h"
#import "TravellerConstants.h"
@implementation Notification4TableViewCell

-(void)awakeFromNib{
    _deleteButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [_deleteButton setTitle:[NSString stringWithUTF8String:ICOMOON_DELET] forState:UIControlStateNormal] ;
    
    _lbl.font=[UIFont fontWithName:font_regular size:font_size_normal_regular];
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}


@end
