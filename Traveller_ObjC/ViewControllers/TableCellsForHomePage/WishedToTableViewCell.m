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
    _bgView.layer.borderColor=[UIColor blackColor].CGColor;
    _bgView.layer.borderWidth=1;
    [self addShaddowToView:_bgView];
    
    _profileImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _profileImageView.layer.borderWidth=2;
    _profileImageView.layer.cornerRadius =6;
    [self addShaddowToView:_profileImageView];
    
    _deleteButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [_deleteButton setTitle:[NSString stringWithUTF8String:ICOMOON_DELETE] forState:UIControlStateNormal] ;
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
