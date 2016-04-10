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
    _imageView.clipsToBounds=NO;
    [_imageView layoutIfNeeded];
    _bgView.layer.borderColor=[UIColor whiteColor].CGColor;
    _bgView.layer.borderWidth=3;
    _bgView.layer.cornerRadius=8;
    [self addShaddowToView:_bgView];
    
    _followLogoLbl.font=[UIFont fontWithName:fontIcomoon size:22];
    _followLogoLbl.textColor=[UIColor whiteColor];
    _followLogoLbl.text =[NSString stringWithUTF8String:ICOMOON_USER];
  
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
