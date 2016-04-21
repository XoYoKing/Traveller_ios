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
@interface CommentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HPGrowingTextViewDelegate>
{
    __weak IBOutlet UITableView *commentTableView;
    __weak IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
        __weak IBOutlet UIButton *closeButton;
    __weak IBOutlet UIView *bgView;

    NSMutableArray * commentArr;
    BOOL commentPageShouldDoPaging;
    int selectedUserIdex;
    int commentPage;
    
    HPGrowingTextView *messageInputView;// Growing TextView For Meassage
    UIButton *sendButton;// Send Button
     UIView *containerView; // Container View for Bottom text view
}
@property(nonatomic,strong)NSString * activityId;
@property(nonatomic,strong)NSString * postedById;
- (IBAction)dismissClick:(id)sender;

@end
