//
//  ViewProfileTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 17/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewProfileTableViewCell.h"

@implementation ViewProfileTableViewCell

- (void)awakeFromNib {
 //   _title.font=[UIFont fontWithName:font_bold  size:font_size_normal_bold];
    _value.font=[UIFont fontWithName:font_regular size:font_size_normal_bold];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
