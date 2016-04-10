#import "AppDelegate.h"


#define iPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define iPhone5or5s  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define iPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define iPhone6plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE
#define iPad  ([[UIScreen mainScreen] bounds].size.height >= 800)?TRUE:FALSE




#define  ICOMOON_BELL "\ue900"
#define  ICOMOON_CHECK "\ue901"
 #define  ICOMOON_UNCHECK "\ue903"
 #define  ICOMOON_SEARCH "\ue904"
#define  ICOMOON_PHOTO "\ue905"
#define  ICOMOON_LOCATION "\ue906"
#define  ICOMOON_USER "\ue908"
#define  ICOMOON_COMMENT "\ue907"
#define  ICOMOON_KEY "\ue909"
#define  ICOMOON_SETTING "\ue90a"
#define  ICOMOON_DELETE "\ue90b"
#define  ICOMOON_PLANE "\ue90c"
#define  ICOMOON_LOGOUT "\ue90d"
#define  ICOMOON_MENU "\ue90e"
#define  ICOMOON_MENU_DOWN "\ue90f"
#define  ICOMOON_MENU_UP "\ue910"
#define  ICOMOON_EARTH "\ue911"
#define  ICOMOON_EYE  "\ue912"
#define  ICOMOON_EYE_CLOSED "\ue913"
#define  ICOMOON_FAVORITE "\ue914"
#define  ICOMOON_CHECKBOX_CHECKED "\ue915"
#define  ICOMOON_CHECKBOX_UNCHECKED "\ue916"
#define  ICOMOON_GOOGLE "\ue902"
#define  ICOMOON_FACEBOOK "\ue917"
#define  ICOMOON_LIKE "\ue918"






#define font_family_regular @"Avenir Next"
#define font_family_regular_size 17
#define fontIcomoon         @"icomoon"
#define fontIcoMoonSize_30  [UIFont fontWithName:@"icomoon" size:30.0f]


#define toastPosition @"center"
#define toastPositionBottom @"bottom"
#define toastPositionBottomUp @"topcenter"
#define toastDuration 3.0f


#define SUCESS @1
#define FAIL @0
#define URL_CONST @"http://trasquare.com/traveller_api/checkurl.php?"
#define LOGIN_ACTION @"login"
#define SIGNUP_ACTION @"signUp"
#define GET_MY_ACTIVITY @"getMyActivity"


#define seriesColor [UIColor colorWithRed:14.0f/255.0f green:176.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define payPalColor [UIColor colorWithRed:2.0f/255.0f green:92.0f/255.0f blue:201.0f/255.0f alpha:1.0f]


#define TEXTFIELD_BORDER_COLOR [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1.0]
#define Place_Picker_Button_Color [UIColor colorWithRed:131.0/255 green:131.0/255 blue:131.0/255 alpha:1]
#define Check_All_Button_Color [UIColor colorWithRed:51.0/255 green:139.0/255 blue:20.0/255 alpha:1]
#define Uncheck_All_Button_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define Date_Picker_Button_Color [UIColor colorWithRed:234.0/255 green:40.0/255 blue:42.0/255 alpha:1]

#pragma mark - validation
#define ACCEPTABLE_NUMERICS_WITH_DECIMAL @"1234567890."
#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-'"
#define ALPHANUMERIC_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define EMAIL_ACCEPTABLE_CHARECTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@._"
#define MAX_CHAR_PASSWORD 15
#define MAX_DIGIT_ZIPCODE 5
#define MAX_CHAR_NAME 15
#define MAX_CHAR_FIRSTNAME_AND_LASTNAME 30
#define MAX_CHAR_EMAIL 50
#define MAX_CHAR_SUBJECT 255
#define MAX_CHAR_MESSAGE 500


#pragma mark - validation messages

#define validation_required_Field @"Please fill all the required field"
#define validation_UsernameWrong @"Please enter valid username"
#define validation_Username @"Please enter username"
#define validation_Password @"Please enter password"
#define validation_PasswordDigits @"Password must have minimum 6 characters and maximum 15 characters"
#define validation_ConfirmPassword @"Password and confirm password does not match"
#define validation_Email @"Please enter the email address"
#define validation_ValidEmail @"Please enter a valid email address"
#define validation_FirstName @"Please enter the First name"
#define validation_LastName @"Please enter the Last name"
#define validation_Address @"Please enter street address"
#define validation_State @"Please select state"
#define validation_City @"Please enter city"
#define validation_Zipcode @"Please enter zipcode"
#define validation_Phone @"Please enter the phone number"
#define validation_WorkPhone @"Please enter the work phone number"
#define validation_CellPhone @"Please enter the cellphone number"
#define validation_companyLocation @"Please select prefered company location"
#define validation_passwordDigits @"Password length should not be less than 6 or greater than 15 character"
#define validation_ExistingPassword @"Please enter existing password"
#define validation_NewPassword @"Please enter new password"
#define validation_RetypePassword @"Please enter retype password"
#define validation_ExistingPasswordDigits @"Existing password must have minimum 6 characters and maximum 15 characters"
#define validation_NewPasswordDigits @"New password must have minimum 6 characters and maximum 15 characters"
#define validation_RetypePasswordDigits @"Retype password must have minimum 6 characters and maximum 15 characters"
#define validation_NewPasswordMatch @"New password and confirm password does not match"

#pragma mark - AlertView messages
#define ERROR @"Error!"
#define SUCCESS_MESSAGE_TITLE @"Success!"
#define SIGN_UP_SUCCESS_MESSAGE @"Your registration is successful."
#define NO_INTERNET_MESSAGE @"Your internet connection is not working"
