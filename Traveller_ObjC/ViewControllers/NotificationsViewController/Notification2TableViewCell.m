//
//  Notification2TableViewCell.m
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "Notification2TableViewCell.h"
#import "TravellerConstants.h"
@implementation Notification2TableViewCell

-(void)awakeFromNib{
        _bgView.layer.borderColor=[UIColor blackColor].CGColor;
        _bgView.layer.borderWidth=1;
        _bgView.layer.cornerRadius=6;
        [self addShaddowToView:_bgView];
    
    _deleteButton.titleLabel.font=[UIFont fontWithName:fontIcomoon size:20];
    [_deleteButton setTitle:[NSString stringWithUTF8String:ICOMOON_DELETE] forState:UIControlStateNormal] ;
    
    
    _textView.layer.borderColor=[UIColor blackColor].CGColor;
    _textView.layer.borderWidth=1;
    _textView.layer.cornerRadius=5;
    [self addShaddowToView:_textView];
    
    _replyButton.layer.borderColor=[UIColor blackColor].CGColor;
    _replyButton.layer.borderWidth=1;
    [self addShaddowToView:_replyButton];
    
    
    
}

-(void)addShaddowToView:(UIView *)view{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 4.0f;
    view.layer.shadowOpacity = 0.80f;
}

@end