//
//  SignUpViewController.h
//  Traveller_ObjC
//
//  Created by Sandip Jadhav on 08/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
#import "FRHyperLabel.h"
#import "TravellerConstants.h"
#import "CountryPicker.h"
@interface SignUpViewController : UIViewController<CountryPickerDelegate>
{
    __weak IBOutlet UITextField *countryTF;
    __weak IBOutlet TextFieldValidator *statusTF;
    __weak IBOutlet TextFieldValidator *userNameTF;
    __weak IBOutlet TextFieldValidator *emailTF;
    __weak IBOutlet TextFieldValidator *passwordTF;
    __weak IBOutlet TextFieldValidator *websiteTF;
    __weak IBOutlet TextFieldValidator *nextDestinationTF;
    __weak IBOutlet TextFieldValidator *cityTF;
    __weak IBOutlet TextFieldValidator *confirmPasswordTF;
    __weak IBOutlet TextFieldValidator *phoneNoTF;
    
    __weak IBOutlet UIImageView *countryImageView;
    __weak IBOutlet UILabel *maleChk;
    __weak IBOutlet UILabel *maleLBL;
    __weak IBOutlet UILabel *femaleChk;
    __weak IBOutlet UILabel *femaleLBL;
    __weak IBOutlet FRHyperLabel *termsLbl;
    __weak IBOutlet UIButton *termButton;
    __weak IBOutlet UIButton *registerBtn;
    __weak IBOutlet UIButton *cancelBtn;
    __weak IBOutlet UIButton *updateBtn;
    
    CountryPicker * countryPicker;
    __weak IBOutlet NSLayoutConstraint *registerHeightConstraint;
}
@property(strong,nonatomic)NSString * fromWhichMenu;
- (IBAction)updateClick:(id)sender;
- (IBAction)maleBtnClick:(id)sender;
- (IBAction)femaleClick:(id)sender;
- (IBAction)termButtonClick:(id)sender;
- (IBAction)registerClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
@end
