//
//  FollowingTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "FollowingTableViewCell.h"
#import "TravellerConstants.h"
@implementation FollowingTableViewCell
-(void)awakeFromNib{
    _bgView.layer.borderColor=[UIColor blackColor].CGColor;
    _bgView.layer.borderWidth=1;
    [self addShaddowToView:_bgView];
    
    _profileImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _profileImageView.layer.borderWidth=2;
    _profileImageView.layer.cornerRadius=8;
    [self addShaddowToView:_profileImageView];
    
    _followButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _followButton.layer.borderWidth=1;
    [self addShaddowToView:_followButton];
    
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}


@end
