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
    _profileImage.layer.borderColor=[UIColor blackColor].CGColor;
    _profileImage.layer.borderWidth=2;
    
    if (iPhone6||iPhone6plus||iPAD) {
        _imageHeight.constant=120;
        _imageWidth.constant=120;
         _profileImage.layer.cornerRadius=60;
    }else{
        _imageHeight.constant=80;
        _imageWidth.constant=80;
         _profileImage.layer.cornerRadius=40;
    }
    
    [_profileImage layoutIfNeeded];
   
    _profileImage.clipsToBounds=YES;
    [_profileImage addShaddow];
    
    [_postImage addShaddow];
    
    _buttonsBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _buttonsBackView.layer.borderWidth=1;
    
    _likeMenuLogoLbl.font=[UIFont fontWithName:fontIcomoon size:26];
    _likeMenuLogoLbl.text =[NSString stringWithUTF8String:ICOMOON_LIKE];

    _likeMenuTxtLbl.font=[UIFont fontWithName:font_bold size:font_size_ComentLike];
    _comentMenuTextLbl.font=[UIFont fontWithName:font_bold size:font_size_ComentLike];
    
    _comentMenuLbl.font=[UIFont fontWithName:fontIcomoon size:20];
    _comentMenuLbl.text =[NSString stringWithUTF8String:ICOMOON_COMMENT1];
    
    _menuBtnOfPost.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    _menuBtnOfPost.titleLabel.textColor=[UIColor redColor];
    _menuBtnOfPost.tintColor=[UIColor redColor];
    [_menuBtnOfPost setTitle:[NSString stringWithUTF8String:ICOMOON_REMOVE_CIRCLE_MINUS] forState:UIControlStateNormal] ;
}


@end
