//
//  SearchCollectionViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "TravellerConstants.h"

@implementation SearchCollectionViewCell
-(void)awakeFromNib{

    [_imageView layoutIfNeeded];
    _bgView.layer.borderColor=[UIColor whiteColor].CGColor;
    _bgView.layer.borderWidth=0;
    _bgView.layer.cornerRadius=0;
    [self addShaddowToView: _bgView ];
    
    
    _imageView.layer.cornerRadius=42;
        _imageView.clipsToBounds=NO;
    _followLogoLbl.font=[UIFont fontWithName:fontIcomoon size:22];
    _followLogoLbl.textColor=[UIColor whiteColor];
    _followLogoLbl.text =[NSString stringWithUTF8String:ICOMOON_USER_ICONPlus];
  
    _userNameLbl.font=[UIFont fontWithName:font_bold size:font_size_button];
    _adressLbl.font=[UIFont fontWithName:font_regular size:12];
    
    _followLogoLbl.hidden=YES;
    _followNameLbl.hidden=YES;
    _followBtn.hidden=YES;
    _followBackView.hidden=YES;
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
