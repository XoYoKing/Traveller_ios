//
//  FeedsTableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "FeedsTableViewCell.h"
#import "TravellerConstants.h"
@implementation FeedsTableViewCell

-(void)awakeFromNib{
    _profileImage.layer.borderColor=[UIColor whiteColor].CGColor;
    _profileImage.layer.borderWidth=2;
    _profileImage.layer.cornerRadius=6;
    [self addShaddowToView:_profileImage];
    
    [self addShaddowToView:_postImage];
    
    _buttonsBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _buttonsBackView.layer.borderWidth=1;
    
    _likeMenuLogoLbl.font=[UIFont fontWithName:fontIcomoon size:26];
    _likeMenuLogoLbl.text =[NSString stringWithUTF8String:ICOMOON_LIKE];

    _comentMenuLbl.font=[UIFont fontWithName:fontIcomoon size:20];
    _comentMenuLbl.text =[NSString stringWithUTF8String:ICOMOON_COMMENT];
    
    _menuBtnOfPost.titleLabel.font=[UIFont fontWithName:fontIcomoon size:15];
    [_menuBtnOfPost setTitle:[NSString stringWithUTF8String:ICOMOON_MENU_DOWN] forState:UIControlStateNormal] ;
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}


@end
