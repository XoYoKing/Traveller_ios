//
//  FeedsTableViewCell.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 09/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRHyperLabel.h"

@interface FeedsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeMenuTxtLbl;
@property (weak, nonatomic) IBOutlet UILabel *likeMenuLogoLbl;
@property (weak, nonatomic) IBOutlet UILabel *comentMenuLbl;
@property (weak, nonatomic) IBOutlet UILabel *comentMenuTextLbl;
@property (weak, nonatomic) IBOutlet FRHyperLabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *extraFeedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIView *buttonsBackView;
@property (weak, nonatomic) IBOutlet UILabel *agoLbl;
@property (weak, nonatomic) IBOutlet UIButton *menuBtnOfPost;
@property (weak, nonatomic) IBOutlet UIButton *likeThumbBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;


@end
