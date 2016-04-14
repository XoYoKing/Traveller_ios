//
//  WIshedToViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 14/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIshedToViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView * wishTableView;
    NSMutableArray * wishedToData;
    BOOL shouldDoPaging;
    int wishPage;
    int  selectedUserIndex;
}
@end
