//
//  CitiesCollectionViewCell.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;
@property (weak, nonatomic) IBOutlet UILabel *wishLogo;
@property (weak, nonatomic) IBOutlet UILabel *wishTitleLbll;
@property (weak, nonatomic) IBOutlet UILabel *placesVisited;
@property (weak, nonatomic) IBOutlet UILabel *placesLogo;
@property (weak, nonatomic) IBOutlet UIButton *wishButton;
@property (weak, nonatomic) IBOutlet UIButton *placesButton;

@end
