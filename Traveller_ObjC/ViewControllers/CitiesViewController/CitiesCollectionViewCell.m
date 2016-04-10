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
    _bgView.layer.borderColor=Uncheck_All_Button_Color.CGColor;
    _bgView.layer.borderWidth=3;
    _bgView.layer.cornerRadius=8;
    [self addShaddowToView:_bgView];
    
    _wishLogo.font=[UIFont fontWithName:fontIcomoon size:20];
    _wishLogo.text=[NSString stringWithUTF8String:ICOMOON_FAVORITE];
    _wishLogo.textColor=Date_Picker_Button_Color;
    
    _placesLogo.font=[UIFont fontWithName:fontIcomoon size:20];
    _placesLogo.text=[NSString stringWithUTF8String:ICOMOON_CHECK];
    
    }

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}
@end
