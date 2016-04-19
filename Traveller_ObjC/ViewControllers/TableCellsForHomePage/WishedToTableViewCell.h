//
//  WishedToTableViewCell.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishedToTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@end
