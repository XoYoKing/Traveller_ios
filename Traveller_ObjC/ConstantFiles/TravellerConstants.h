
#pragma mark --------------------------Icomoon Constants-------------------------------

#define ICOMOON_BELL "\ue7f4"
#define ICOMOON_LIKE "\ue901"
#define ICOMOON_EDIT1 "\ue902"
#define ICOMOON_SETTING "\ue903"
#define ICOMOON_CHECK "\ue904"
#define ICOMOON_CROSS "\ue905"
#define ICOMOON_SEARCH "\ue906"
#define ICOMOON_FORWARD_ARROW "\ue907"
#define ICOMOON_EARTH "\ue908"
#define ICOMOON_FORWARD_ARROW2 "\ue909"
#define ICOMOON_EDIT "\ue90a"
#define ICOMOON_IMAGE_PHOTO "\ue90b"
#define ICOMOON_CAMERA "\ue90c"
#define ICOMOON_PRICETAG "\ue90d"
#define ICOMOON_LOCATION "\ue90e"
#define ICOMOON_ALARM_WATCH "\ue90f"
#define ICOMOON_ALARM_WATCH2 "\ue910"
#define ICOMOON_COMMENT1 "\ue911"
#define ICOMOON_COMMENT2 "\ue912"
#define ICOMOON_USER_ICONPlus "\ue913"
#define ICOMOON_USERICON_minus "\ue914"
#define ICOMOON_KEY "\ue915"
#define ICOMOON_SETTING2 "\ue916"
#define ICOMOON_SPOON "\ue917"
#define ICOMOON_DELET "\ue918"
#define ICOMOON_JET "\ue919"
#define ICOMOON_MENU "\ue91a"
#define ICOMOON_EYEOPEN "\ue91b"
#define ICOMOON_EYECLOSE "\ue91c"
#define ICOMOON_BOOKMARK "\ue91d"
#define ICOMOON_BOOKMARK2 "\ue91e"
#define ICOMOON_HEART "\ue91f"
#define ICOMOON_BACK_CIECLE_LEFT "\ue920"
#define ICOMOON_ CHECKBOX_TICK "\ue921"
#define ICOMOON_UNCHECK "\ue922"
#define ICOMOON_RADIO_CHECK "\ue923"
#define ICOMOON_RADIO_UNCHECK "\ue924"
#define ICOMOON_GOOGLE "\ue925"
#define ICOMOON_FACEBOOK "\ue926"
#define ICOMOON_ACCOUNT_CIRCLE "\ue853"
#define ICOMOON_PHOTOCAMERA "\ue412"
#define ICOMOON_CHECK_CIRCLE "\ue86c"
#define ICOMOON_EXPLORER "\ue87a"
#define ICOMOON_HEART_UNCHECK "\ue87e"
#define ICOMOON_FLAG "\eb45"
#define ICOMOON_LOCAL_OFFER "\ue54e"
#define ICOMOON_NOTIFICATION "\ue900"
#define ICOMOON_REMOVE_CIRCLE_MINUS "\ue15d"
#define ICOMOON_TRISHUL "\ue56c"
#define ICOMOON_SIGNOUT "\ue8c6"
#define ICOMOON_EYE_CLOSE2 "\ue8f5"
#define ICOMOON_WATCH "\ue927"




#pragma mark --------------------------Font Details-------------------------------

#define font_regular @".SFUIText-Regular"
#define font_button @".SFUIText-Regular"
#define font_bold @".SFUIText-Semibold"
#define fontIcomoon @"icomoon"


#define font_size_normal_regular iPAD ? 20 : (IS_IPHONE_6 ? 18.0f : 16.0f)
#define font_size_normal_bold iPAD ? 20 : (IS_IPHONE_6 ? 19.0f : 15.0f)
#define font_size_ComentLike iPAD ? 20 : (IS_IPHONE_6 ? 14.0f : 12.0f)
#define font_size_bold iPAD ? 25 : (IS_IPHONE_6 ? 24.0f : 22.0f)
#define font_size_button iPAD ? 20 : (IS_IPHONE_6 ? 20.0f : 17.0f)
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
#define throwRefreshLike @"refreshLikeCell"

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
#define ACTION_GET_MY_FOLLOW_LIST @"getMyFollowList"
#define ACTION_GET_WISH_TO @"getWishTo"
#define ACTION_GET_VISITED_CITIES @"getVisitedCities"
#define ACTION_GET_CITIES @"getCities"
#define ACTION_GET_NOTIFICATION @"getInvitationAskTip"
#define ACTION_ADD_ACTIVITY @"addUserActivity"
#define ACTION_GET_WISH_TO_VISITED @"getCityVisitedPerson"
#define ACTION_ADD_FOLLOWER @"addFollowers"
#define ACTION_SEARCH_USER @"searchuser"
#define ACTION_GET_VISITED_CITY_PEOPLE @"getCityVisitedPerson"
#define ACTION_GET_UNVISITED_CITY_PEOPLE @"getUnvisitedUsers"
#define ACTION_ASK_FOR_TIP @"addAskForTip"
#define ACTION_INVITE @"inviteToJoin"
#define ACTION_GET_CITY_FEED @"getCityActivity"
#define ACTION_ADD_FOLLOWER @"addFollowers"
#define ACTION_GET_USER_DETAILS @"getUserDetails"
#define ACTION_GET_LIKE_DETAILS @"getLikeList"
#define ACTION_ADD_LIKE @"addLike"
#define ACTION_GET_COMMENT_DETAILS @"getComment"
#define ACTION_COMMENT_ADD @"addComment"
#define ACTION_FEED_DELETE @"delete"

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
#define segment_selected_Color [UIColor whiteColor]
#define segment_disselected_Color [UIColor colorWithRed:63.0/255 green:114.0/255 blue:155.0/255 alpha:1]
#define menu_Color [UIColor colorWithRed:63.0/255 green:114.0/255 blue:155.0/255 alpha:1]
#define menu_background_Color [UIColor colorWithRed:63.0/255 green:114.0/255 blue:155.0/255 alpha:1]
#define navigation_background_Color [UIColor colorWithRed:63.0/255 green:114.0/255 blue:155.0/255 alpha:1]
#define back_btn_Color [UIColor whiteColor]

#pragma mark --------------------------For Parallax Effect on Feed View-------------------------------

#define feed_headerHeight iPAD ? 350 : (IS_IPHONE_6 ? 300.0 : 220.0)
#define feed_subHeaderHeight  iPAD ? 100 : (IS_IPHONE_6 ? 100 : 100.0)
#define feed_avatarImageSize iPAD ? 150 : (IS_IPHONE_6 ? 120 : 100)
#define feed_avatarImageCompressedSize iPAD ? 60 : (IS_IPHONE_6 ? 55 : 45)


#pragma mark --------------------------Validation messages-------------------------------

#define no_internet_message @"Please check your internet connection"
