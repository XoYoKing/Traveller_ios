//
//  SearchViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCollectionViewCell.h"
#import "TravellerConstants.h"
#import "GIBadgeView.h"
#import "NotificationsViewController.h"

@interface SearchViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *searchCollectionView;
    GIBadgeView * badgeView;
}
@end
