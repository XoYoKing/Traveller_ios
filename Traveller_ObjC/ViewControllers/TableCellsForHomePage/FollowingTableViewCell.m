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
   
    [_profileImageView addShaddow];
    
    _followButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _followButton.layer.borderWidth=1;
    [_followButton addShaddow];
    
    _profileImageView.clipsToBounds=YES;
    [_profileImageView addBlackLayerAndCornerRadius:45 AndWidth:1];
    
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}


@end
