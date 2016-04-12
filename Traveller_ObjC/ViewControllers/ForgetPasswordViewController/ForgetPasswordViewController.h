//
//  ForgetPasswordViewController.h
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 12/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController
{
    IBOutlet UIButton *submitBtn;
    IBOutlet UIButton *cancelBtn;
    IBOutlet TextFieldValidator *emailTF;
    IBOutlet UIView *alertBackView;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *subTitleLbl;
}
@end
