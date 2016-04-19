//
//  LikeViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeTableViewCell.h"
#import "TravellerConstants.h"
@interface LikeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIButton *closeButton;
    __weak IBOutlet UITableView *likeTableView;
    int likePage;
    NSMutableArray * totalLike;
    
   BOOL likePageShouldDoPaging;
    int selectedUserIdex;
}

@property(strong,nonatomic) NSString * userId;
@property(strong,nonatomic) NSString * activityId;


@end
