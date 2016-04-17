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

@interface SearchViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UICollectionView *searchCollectionView;
    GIBadgeView * badgeView;
    
    NSMutableArray * globalArrayToShow;
    NSMutableArray * citiesArray;
    BOOL citiesPagingBoolean;
    int citiesPage;
    
    __weak IBOutlet UITextField *searchTF;
    __weak IBOutlet UIButton *searchBtn;
    
    int selectedIndex;
}
@end
