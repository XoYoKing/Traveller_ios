
#pragma mark --------------------------Icomoon Constants-------------------------------
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


#pragma mark --------------------------Font Details-------------------------------
#define font_regular @"Avenir Next"
#define font_button @"Avenir Next"
#define font_bold @"Futura"
#define fontIcomoon @"icomoon"

#define font_size_normal_regular iPAD ? 20 : (IS_IPHONE_6 ? 17.0f : 12.0f)
#define font_size_normal_bold iPAD ? 20 : (IS_IPHONE_6 ? 17.0f : 12.0f)
#define font_size_bold iPAD ? 25 : (IS_IPHONE_6 ? 22.0f : 20.0f)
#define font_size_button iPAD ? 20 : (IS_IPHONE_6 ? 18.0f : 14.0f)
#define logo_Size_Big iPAD ? 35 : (IS_IPHONE_6 ? 30.0f : 22.0f)
#define logo_Size_Small iPAD ? 30 : (IS_IPHONE_6 ? 24.0f : 20.0f)

#pragma mark --------------------------Corner Radius/Border Width/Padding-------------------------------
#define cornerRadius_Button 4
#define cornerRadius_Image 8
#define borderWidth_Button 1
#define borderWidth_Image 4
#define leftPadding 35
#define rightPadding 35
#define mainUserProfileICornerRadius  8



#pragma mark --------------------------Toast Constants-------------------------------
#define toastPosition @"center"
#define toastPositionBottom @"bottom"
#define toastPositionBottomUp @"topcenter"
#define toastDuration 3.0f


#pragma mark --------------------------Internal Notification Codes-------------------------------
#define throwNotificationStatus @"sendCountOfNotification"

#pragma mark --------------------------Webservice Codes-------------------------------
#define SUCESS @1
#define FAIL @0

#pragma mark --------------------------Webservice Constants-------------------------------
#define URL_CONST @"http://trasquare.com/traveller_api/checkurl.php?"
#define ACTION_LOGIN @"login"
#define ACTION_SIGNUP @"signUp"
#define ACTION_GET_MY_ACTIVITY @"getMyActivity"
#define ACTION_FORGET_PASSWORD @"forgotPassword"
#define ACTION_GET_FOLLOWER_LIST @"getFollowerList"
#define ACTION_GET_FOLLOW_LIST @"getFollowList"
#define ACTION_GET_WISH_TO @"getWishTo"
#define ACTION_GET_VISITED_CITIES @"getVisitedCities"
#define ACTION_GET_CITIES @"getCities"
#define ACTION_GET_NOTIFICATION @"getInvitationAskTip"
#define ACTION_ADD_ACTIVITY @"addUserActivity"
#define ACTION_GET_WISH_TO_VISITED @"getCityVisitedPerson"
#define ACTION_ADD_FOLLOWER @"addFollowers"
#define ACTION_SEARCH_USER @"searchuser"
#define ACTION_GET_VISITED_CITY_PEOPLE @"getCityVisitedPerson"

#pragma mark --------------------------Color Codes-------------------------------
#define userShouldDOButoonColor [UIColor colorWithRed:14.0f/255.0f green:176.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define userShouldNOTDOButoonColor [UIColor colorWithRed:14.0f/255.0f green:176.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define disabledColor [UIColor colorWithRed:14.0f/255.0f green:176.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define whiteBorderColor [UIColor WhiteColor].CGColor
#define blackBorderColor [UIColor WhiteColor].CGColor
#define Check_Color [UIColor colorWithRed:51.0/255 green:139.0/255 blue:20.0/255 alpha:1]
#define Uncheck_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define Like_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define comment_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define share_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define segment_selected_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define segment_disselected_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define menu_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define menu_background_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]
#define back_btn_Color [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1]

#pragma mark --------------------------For Parallax Effect on Feed View-------------------------------
#define feed_headerHeight iPAD ? 350 : (IS_IPHONE_6 ? 300.0 : 220.0)
#define feed_subHeaderHeight  iPAD ? 100 : (IS_IPHONE_6 ? 100 : 100.0)
#define feed_avatarImageSize iPAD ? 150 : (IS_IPHONE_6 ? 120 : 100)
#define feed_avatarImageCompressedSize iPAD ? 60 : (IS_IPHONE_6 ? 55 : 45)


#pragma mark --------------------------Validation messages-------------------------------
#define no_internet_message @"Please check your internet connection"
