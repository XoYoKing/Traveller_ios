//
//  TravellingToViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIBadgeView.h"
#import "NotificationsViewController.h"
#import "TravellerConstants.h"
#import "LocationFeedViewController.h"

@interface TravellingToViewController : UIViewController<UITextFieldDelegate>
{
    __weak IBOutlet UICollectionView *citiesCollectionView;
    __weak IBOutlet UITextField *searchTF;
    __weak IBOutlet UIButton *searchBtn;
    GIBadgeView * badgeView;
    
    NSMutableArray * globalArrayToShow;
    NSMutableArray * citiesArray;
    BOOL citiesPagingBoolean;
    int citiesPage;
}
- (IBAction)searchClick:(id)sender;@end
