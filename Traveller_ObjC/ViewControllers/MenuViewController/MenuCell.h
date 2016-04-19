//
//  MenuCell.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuImgLbl;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *menuBGView;
@end
