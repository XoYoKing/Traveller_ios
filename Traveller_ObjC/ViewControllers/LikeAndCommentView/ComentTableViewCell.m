//
//  ComentTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ComentTableViewCell.h"

@implementation ComentTableViewCell

- (void)awakeFromNib {
    
    _profileImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _profileImageView.layer.borderWidth=2;
    _profileImageView.layer.cornerRadius=6;
    [self addShaddowToView:_profileImageView];
    
}
-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
