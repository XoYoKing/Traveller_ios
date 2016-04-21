//
//  ChangePasswordViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 20/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
{
    __weak IBOutlet TextFieldValidator *confirmNewPass;
    __weak IBOutlet TextFieldValidator *newPass;
    __weak IBOutlet TextFieldValidator *oldPass;
    __weak IBOutlet UILabel *lbl3;
    __weak IBOutlet UILabel *lbl2;
    __weak IBOutlet UILabel *lbl1;
}
@end
