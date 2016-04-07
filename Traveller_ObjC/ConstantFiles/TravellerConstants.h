
#define iPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define iPhone5or5s  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define iPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define iPhone6plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE


#pragma mark ------------------ data functions ---------------------
#define func_paypal_ids @"/general_data_api.php?method=get_paypal_details"
#define func_deviceRegistration @"/apps_settings_api.php?method=savedevice"
#define func_signIn     @"/profile_api.php?method=signin"
#define func_logout    @"/profile_api.php?method=logout"
#define func_forgotPassword     @"/profile_api.php?method=forgot_password"
#define fun_companyName         @"/profile_api.php?method=getCompanyIdLocations"
#define func_MyProfile @"/profile_api.php?method=getprofileinfo"
#define func_UpdateProfile @"/profile_api.php?method=update_profile"
#define func_ContactUs @"/profile_api.php?method=contactus"
#define func_dashboard          @"/dashboard_api.php?method=getdashboard"
#define func_globalData   @"/general_data_api.php?method=getgeneraldata"
#define func_CompanyLocations @"/profile_api.php?method=getCompanyLocations"
#define func_signUp @"/profile_api.php?method=signup"
#define func_messageList @"/message_api.php?method=list_message"
#define func_adminList @"/message_api.php?method=get_admin_list"
#define func_composeMessage @"/message_api.php?method=compose_message"
#define fun_messageThread @"/message_api.php?method=message_thread"
#define fun_replayMessage @"/message_api.php?method=reply_message"
#define func_change_password @"/profile_api.php?method=change_password"

//--------------------------------Membership----------------------------
#define func_getMemberShipDetails @"/profile_history_api.php?method=get_membership_details"
#define func_cancleMembership @"/profile_history_api.php?method=membership_cancellation"
#define func_cancleMembershipPayment @"/profile_history_api.php?method=membership_cancel_payment"

//-----------------------------Appoinment-------------------------------
#define func_upcomingAppointment @"/upcoming_appointment_api.php?method=appointment_list"
#define func_upcomingAppointmentDetails @"/upcoming_appointment_api.php?method=appointment_details"
#define func_Appointment_Cancellation_Terms @"/upcoming_appointment_api.php?method=cancellation_terms"
#define func_Appointment_Cancellation @"/upcoming_appointment_api.php?method=appointment_cancellation"
#define Func_getCancelReason @"/upcoming_appointment_api.php?method=cancel_appointment_details"
//---------------------------Series History--------------------------------
#define func_getSeriesHistoryData @"/profile_history_api.php?method=get_series_history"
#define func_getSeriesDetails @"/profile_history_api.php?method=get_series_details"


//---------------------------Wellness Credit History------------------------------------------------
#define func_getWellnessCreditHistory @"/profile_history_api.php?method=wellness_history"
//----------------------------GiftCertificate-----------------------------
#define func_giftCertificateUserList @"/profile_history_api.php?method=get_gc_history"
#define func_giftCertificateDetails @"/profile_history_api.php?method=get_gc_details"
#define func_SendGiftCertificate @"/profile_history_api.php?method=send_gift_certificate"

//--------------------------Popups---------------------------------------
#define func_DeclinePopups @"/upcoming_appointment_api.php?method=decline_popups"
#define func_DeclinePopupsPayment @"/upcoming_appointment_api.php?method=decline_popup_payment"

//-------------------------Booking Services-----------------------------
#define func_BookingService_BookingDashBoard @"/book_services_api.php?method=booking_dashboard"
#define Func_BookingService_BookingDashboardTimeslot @"/book_services_api.php?method=booking_dashboard_timeslot"
#define func_BookingService_BookingDashboardSelectLocation @"/book_services_api.php?method=booking_dashboard_locations"
#define Func_BookingService_DisplayTimeSlot @"/book_services_api.php?method=booking_appointment_timeslot"
#define Func_BookingService_select_random_therapist @"/book_services_api.php?method=select_random_therapist"

#define Func_BookingService_DeleteCometId @"/book_services_api.php?method=delete_comet_id"
#define Func_BookingService_WaitingListDisplay @"/upcoming_appointment_api.php?method=waiting_list"
#define Func_BookingService_WaitingListDisplay_Multiple @"/upcoming_appointment_api.php?method=waiting_list_multiple_schedules"
#define Func_BookingService_WaitingListAddRecord @"/upcoming_appointment_api.php?method=add_to_waiting_list"
#define Func_bookingService_booking_appointment_stylelength @"/book_services_api.php?method=booking_appointment_stylelength"
#define Func_BookingWebservice_getRecuringDetails @"/book_services_api.php?method=get_recurring_schedules"
#define Func_BookingWebservice_displayAllPaymentOption_CompanyPaid @"/book_services_api.php?method=appointment_payment_select"
#define Func_BookingWebservice_check_gc_available @"/book_services_api.php?method=check_gc_available"
#define Func_BookingWebservice_get_appointmnet_payment @"/book_services_api.php?method=get_appointmnet_payment"
#define Func_BookingService_delete_recurrence_comet_ids @"/book_services_api.php?method=delete_recurrence_comet"
#define Func_BookingService_paypal_response_update @"/book_services_api.php?method=paypal_response_update"
#define Function_ShowTherapist_info @"/book_services_api.php?method=show_therapist_data"

//--------------------------Edit Appointment------------------------------
#define func_Edit_Appointment_Date @"/book_services_api.php?method=edit_appointment_date"
#define func_Update_Appointment_Date @"/book_services_api.php?method=update_appointment_date"
#define func_Edit_Appointment_Time @"/book_services_api.php?method=edit_appointment_time"
#define func_Update_Appointment_Time @"/book_services_api.php?method=update_appointment_time"
#define func_DisplayStyle_Length @"/book_services_api.php?method=booking_appointment_stylelength"

#pragma mark Error_codes
#define SUCCESS @(101)
#define FAILURE @(102)

//------------------------Credit Card Info------------------------
#define func_Credit_Card_Info @"/general_data_api.php?method=list_credit_card"
#define func_add_Card_Info @"/general_data_api.php?method=add_credit_card"
#define func_delete_Card_Info @"/general_data_api.php?method=delete_credit_card"
#define func_edit_Card_Info @"/general_data_api.php?method=edit_credit_card"
#define func_get_Card_Info @"/general_data_api.php?method=get_credit_card"
#pragma mark - general constants

#pragma Font Family

#define font_family_regular @"Roboto"
#define font_family_thin    @"Roboto-Thin"
#define font_family_light   @"Roboto-Light"
#define font_family_Bold  @"HelveticaNeue"
#define fontIcomoon         @"icomoon"
#define fontIcoMoonSize_30  [UIFont fontWithName:@"icomoon" size:30.0f]
#define kAppThemeRedColor UIColorFromHEX(0xfb4133)
#define alertDismissDuration   3.0f
#define alertDismissDurationForMultilineMessage   5.0f
#define toastPosition @"center"
#define toastPositionBottom @"bottom"
#define toastPositionBottomUp @"topcenter"
#define toastDuration 2.0f
#define font_size_for_textField 17
#define font_size_for_label 17

//No record found label size
#define font_size_headerLabel IS_IPAD ? 20.0f :(IS_IPHONE_6 ? 17.0f : 14.0f)
#define font_size_DashboardMenuTitle IS_IPAD ? 22.0f : (IS_IPHONE_6 ? 20.0f : 18.0f)

#define kPickerBackgroundColor [UIColor colorWithRed:213.0f/255.0f green:218.0f/255.0f blue:224.0f/255.0f alpha:1.0f]

#define selfBookedColor [UIColor colorWithRed:255.0f/255.0f green:51.0f/255.0f blue:204.0f/255.0f alpha:0.3f]
#define bookedByOtherColor [UIColor colorWithRed:250.0f/255.0f green:103.0f/255.0f blue:93.0f/255.0f alpha:0.3f]
#define processingColor [UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:0.3f]
#define blockedColor [UIColor colorWithRed:229.0f/255.0f green:220.0f/255.0f blue:215.0f/255.0f alpha:1.0f]

#define seriesColor [UIColor colorWithRed:14.0f/255.0f green:176.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define specialColor [UIColor colorWithRed:209.0f/255.0f green:26.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define membershipColor UIColorFromHEX(0xfb4133)
#define wellnessColor [UIColor colorWithRed:237.0f/255.0f green:160.0f/255.0f blue:48.0f/255.0f alpha:1.0f]
#define giftcardColor [UIColor colorWithRed:252.0f/255.0f green:45.0f/255.0f blue:57.0f/255.0f alpha:1.0f]

#define cashColor [UIColor colorWithRed:4.0f/255.0f green:177.0f/255.0f blue:58.0f/255.0f alpha:1.0f]
#define checkColor [UIColor colorWithRed:191.0f/255.0f green:184.0f/255.0f blue:5.0f/255.0f alpha:1.0f]
#define ccColor [UIColor colorWithRed:5.0f/255.0f green:187.0f/255.0f blue:225.0f/255.0f alpha:1.0f]
#define payPalColor [UIColor colorWithRed:2.0f/255.0f green:92.0f/255.0f blue:201.0f/255.0f alpha:1.0f]
#define bottomTipColor [UIColor colorWithRed:238.0f/255.0f green:50.0f/255.0f blue:28.0f/255.0f alpha:1.0f]

#pragma mark - Bottom Tabs View

#define Bottom_TabButtons_Title_color     [UIColor grayColor]
#define Bottom_TabButtons_Title_color_Highlight     [UIColor colorWithRed:251.0f/255.0f green:65.0f/255.0f blue:52.0f/255.0f alpha:1.0f]


#define Bottom_TabButtons_Title_Font [UIFont fontWithName:@"Roboto-Light" size:17]

#define Bottom_TabButtons_Background_color      [UIColor whiteColor]

#define Bottom_TabButtons_Boarder_color     [BTCommonFunctions colorWithHexString:@"#ffebebeb"]

#define BottomTabBackgroundColor [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1]
#define HighlightViewBackgroundColor [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1]

#define Bottom_TabButtons_Boarder_Width     1

#pragma mark - Login&Sign-up
#define font_size_Welcome 36
#define font_size_SignIn 20
#define font_size_SignUp 33
#define textfield_Boarder_color     [BTCommonFunctions colorWithHexString:@"#ffebebeb"]
#define textfield_text_Color        [UIColor grayColor]
#define label_LightGray_caption_color [UIColor lightGrayColor]
#define label_Black_caption_color [UIColor blackColor]
#pragma mark - Registration

#pragma mark - My Profile


#pragma mark -Change Password
#define font_size_changPwdTextfieldForI6 17
#define font_size_changPwdTextfieldForI4 17


#pragma mark - Membership
#define font_size_membership_17 17
#define font_size_membership_14 14



#pragma mark- My Appointment
#define font_size_for_Price 16
#define font_size_for_NavigatonTittle 23
#define font_size_for_Cell_Edit_Button  [UIFont fontWithName:@"icomoon" size:35.0f]
#define font_size_for_Cell_Cancel_Button [UIFont fontWithName:@"icomoon" size:35.0f]
#define font_size_for_AppointmentcellLabelForI6 17
#define font_size_for_AppointmentcellLabelForI4 14

#pragma mark-GiftCertificate
#define font_size_for_cellLabelForI6 17
#define font_size_for_cellLabelForI5 15
#define font_size_for_cellLabelForI4 14
#define font_size_for_cellLabelForI2 12

#pragma mark - My Messages Fonts
#define font_size_17 17
#define font_size_20 20

#pragma mark - WellnessCredit
#define fontSize_WellNess_13 13
#define fontSize_WellNess_15 15

#pragma mark-Edit Date Fonts
#define fontSize_editDate_17 17
#define fontSize_editDate_15 15

#pragma mark-Credit Card Info Fonts
#define Card_info_17 17
#define Card_info_15 15

#pragma mark-ConfirmationViewController Fonts
#define Confirmation_17 17
#define Confirmation_15 15

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


#pragma mark - Notifications
#define NSMenuControllerRefreshNotification @"NSMenuControllerRefreshNotification"
#define NSDeclinePopUpNotification @"DeclinedPopupsNotification"
#define NSSelectFirstMenuNotification @"SelectionOfFirstMenu"
#define NSShowLoaderOnTableNotification @"ShowLoaderOnTable"
#define NSHideLoaderOnTableNotification @"hideLoaderOnTable"