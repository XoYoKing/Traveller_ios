//
//  CitiesViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
#import "TravellerConstants.h"

@interface CitiesViewController : UIViewController
{
    __weak IBOutlet UICollectionView *citiesCollectionView;
    GIBadgeView * badgeView;
}
@end
