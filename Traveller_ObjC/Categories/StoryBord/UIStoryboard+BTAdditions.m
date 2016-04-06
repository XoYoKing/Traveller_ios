//
//  UIStoryboard+BTAdditions.m
//  BTCorporate
//
//  Created by Rahul Gunjote on 28/04/15.
//  Copyright (c) 2015 Benchmark It Solutions. All rights reserved.
//

#import "UIStoryboard+BTAdditions.h"

@implementation UIStoryboard (BTAdditions)
+ (instancetype)storyboardWithName:(NSString *)name
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *storyboardName = name ?: [bundle objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
    return [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
}

#pragma mark - Storyboards

+ (instancetype)mainStoryboard
{
    static id _mainStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mainStoryboard = [UIStoryboard storyboardWithName:@"Main"];
    });
    return _mainStoryboard;
}
+ (instancetype)bookingStoryboard
{
    static id _bookingStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bookingStoryboard = [UIStoryboard storyboardWithName:@"Booking"];
    });
    return _bookingStoryboard;
}
+ (instancetype)profileStoryboard
{
    static id _profileStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _profileStoryboard = [UIStoryboard storyboardWithName:@"Profile"];
    });
    return _profileStoryboard;
}
+ (instancetype)messagesStoryboard
{
    static id _messagesStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messagesStoryboard = [UIStoryboard storyboardWithName:@"Messages"];
    });
    return _messagesStoryboard;
}

+ (instancetype)appointmentStoryboard
{
    static id _appointmentStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appointmentStoryboard = [UIStoryboard storyboardWithName:@"Appointment"];
    });
    return _appointmentStoryboard;
}

+ (instancetype)membershipStoryboard
{
    static id _memberShipStoryBord = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _memberShipStoryBord = [UIStoryboard storyboardWithName:@"membership"];
    });
    return _memberShipStoryBord;
}
+ (instancetype)giftcertificateStoryboard
{
    static id _giftcertificateStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _giftcertificateStoryboard = [UIStoryboard storyboardWithName:@"GiftCertificate"];
    });
    return _giftcertificateStoryboard;
}

+ (instancetype)popupStoryboard
{
    static id _memberShipStoryBord = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _memberShipStoryBord = [UIStoryboard storyboardWithName:@"Popups"];
    });
    return _memberShipStoryBord;
}

+ (instancetype)seriesStoryboard
{
    static id seriesStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        seriesStoryboard = [UIStoryboard storyboardWithName:@"SeriesList"];
    });
    return seriesStoryboard;
}

+ (instancetype)wellnessStoryboard
{
    static id wellnessStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wellnessStoryboard = [UIStoryboard storyboardWithName:@"Wellness"];
    });
    return wellnessStoryboard;
}

+ (instancetype)CreditCardInfo
{
    static id CreditCardInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CreditCardInfo = [UIStoryboard storyboardWithName:@"CreditCardInfo"];
    });
    return CreditCardInfo;
}
+ (instancetype)confirmationStoryboard
{
    static id confirmationStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        confirmationStoryboard = [UIStoryboard storyboardWithName:@"confirmation"];
    });
    return confirmationStoryboard;
}
+ (instancetype)settingsStoryboard
{
    static id settingsStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingsStoryboard = [UIStoryboard storyboardWithName:@"Settings"];
    });
    return settingsStoryboard;
}
+ (instancetype)helpStoryboard
{
    static id helpStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpStoryboard = [UIStoryboard storyboardWithName:@"Help"];
    });
    return helpStoryboard;
}



@end
