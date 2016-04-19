//
//  WishedToTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "WishedToTableViewCell.h"
#import "TravellerConstants.h"
@implementation WishedToTableViewCell

-(void)awakeFromNib{
    _profileImageView.clipsToBounds=YES;
    [_profileImageView addBlackLayerAndCornerRadius:40 AndWidth:1];
    [self addShaddowToView:_profileImageView];
    
    _deleteButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [_deleteButton setTitle:[NSString stringWithUTF8String:ICOMOON_DELET] forState:UIControlStateNormal] ;
    _deleteButton.titleLabel.textColor  = userShouldNOTDOButoonColor;
    _deleteButton.tintColor =userShouldNOTDOButoonColor ;
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
