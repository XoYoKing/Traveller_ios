//
//  LikeTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "LikeTableViewCell.h"

@implementation LikeTableViewCell

- (void)awakeFromNib {
    _bgView.layer.borderColor=[UIColor blackColor].CGColor;
    _bgView.layer.borderWidth=1;
    _bgView.layer.cornerRadius=6;
    [self addShaddowToView:_bgView];
    
    _profileImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _profileImageView.layer.borderWidth=2;
    _profileImageView.layer.cornerRadius=6;
    [self addShaddowToView:_profileImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
