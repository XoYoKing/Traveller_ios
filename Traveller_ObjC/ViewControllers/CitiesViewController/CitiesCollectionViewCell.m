//
//  CitiesCollectionViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "CitiesCollectionViewCell.h"
#import "TravellerConstants.h"

@implementation CitiesCollectionViewCell
-(void)awakeFromNib{
    _cityImageView.clipsToBounds=NO;
    [_cityImageView layoutIfNeeded];
    _bgView.layer.borderColor=segment_selected_Color.CGColor;
    _bgView.layer.borderWidth=3;
    _bgView.layer.cornerRadius=8;
    [self addShaddowToView:_bgView];
    
    _wishLogo.font=[UIFont fontWithName:fontIcomoon size:20];
    _wishLogo.text=[NSString stringWithUTF8String:ICOMOON_FAVORITE];
    _wishLogo.textColor=segment_selected_Color;
    
    _placesLogo.font=[UIFont fontWithName:fontIcomoon size:20];
    _placesLogo.text=[NSString stringWithUTF8String:ICOMOON_CHECK];
    
    _cityNameLbl.font=[UIFont fontWithName:font_bold size:font_size_bold];
    
    }

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
