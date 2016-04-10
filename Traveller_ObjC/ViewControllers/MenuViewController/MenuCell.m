//
//  MenuCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "MenuCell.h"
#import "TravellerConstants.h"
@implementation MenuCell
-(void)awakeFromNib{
    _menuBGView.layer.borderColor=[UIColor blackColor].CGColor;
    _menuBGView.layer.borderWidth=1;
    [self addShaddowToView:_menuBGView];
    _menuBGView.backgroundColor=Date_Picker_Button_Color;
    _menuImgLbl.textColor=[UIColor whiteColor];
    _menuTitleLbl.textColor=[UIColor whiteColor];
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end
