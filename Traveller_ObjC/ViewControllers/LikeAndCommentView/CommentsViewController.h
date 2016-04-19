//
//  CommentsViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 10/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravellerConstants.h"
#import "HPGrowingTextView.h"
#import "FRHyperLabel.h"
@interface CommentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *commentTableView;
    __weak IBOutlet NSLayoutConstraint *containerViewHeight;
    __weak IBOutlet UIView *containerView;
        __weak IBOutlet UIButton *closeButton;
    __weak IBOutlet UIView *bgView;
}
- (IBAction)dismissClick:(id)sender;
@end
