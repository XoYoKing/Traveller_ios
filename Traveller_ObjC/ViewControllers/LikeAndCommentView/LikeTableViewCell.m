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

    [_bgView addShaddow];
    [_profileImageView addShaddow];
    
    _profileImageView.layer.cornerRadius=30;
    _profileImageView.clipsToBounds=YES;
    
    _followBtn.titleLabel.font=[UIFont fontWithName:font_button size:font_size_button];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
