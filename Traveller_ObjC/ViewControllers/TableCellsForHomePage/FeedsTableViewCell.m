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
    
    if (iPhone6||iPhone6plus||iPAD) {
        _imageHeight.constant=100;
        _imageWidth.constant=100;
         _profileImage.layer.cornerRadius=50;
    }else{
        _imageHeight.constant=60;
        _imageWidth.constant=60;
         _profileImage.layer.cornerRadius=30;
    }
    
    [_profileImage layoutIfNeeded];
   
    _profileImage.clipsToBounds=YES;
    [_profileImage addShaddow];
    
    [_postImage addShaddow];
    
    _buttonsBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _buttonsBackView.layer.borderWidth=1;
    
    _likeMenuLogoLbl.font=[UIFont fontWithName:fontIcomoon size:26];
    _likeMenuLogoLbl.text =[NSString stringWithUTF8String:ICOMOON_LIKE];

    _comentMenuLbl.font=[UIFont fontWithName:fontIcomoon size:20];
    _comentMenuLbl.text =[NSString stringWithUTF8String:ICOMOON_COMMENT];
    
    _menuBtnOfPost.titleLabel.font=[UIFont fontWithName:fontIcomoon size:15];
    [_menuBtnOfPost setTitle:[NSString stringWithUTF8String:ICOMOON_MENU_DOWN] forState:UIControlStateNormal] ;
}


@end
