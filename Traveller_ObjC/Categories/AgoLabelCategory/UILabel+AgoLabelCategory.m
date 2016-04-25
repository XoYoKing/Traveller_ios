//
//  UILabel+AgoLabelCategory.m
//  Traveller_ObjC
//
//  Created by Sagar Shirbhate on 18/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "UILabel+AgoLabelCategory.h"

@implementation UILabel (AgoLabelCategory)

-(void)setAgoText: (NSString*)miliSeconds{
    
    int milisecond =[miliSeconds intValue];
    
    NSDate * dateA = [NSDate dateWithTimeIntervalSince1970:milisecond];
    NSDate *dateB=[NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                               fromDate:dateA
                                                 toDate:dateB
                                                options:0];
    
    NSString * str =@"";
    
    if((int)components.month!=0) {
        if((int)components.month==1)
            str =[NSString stringWithFormat:@"%ld Month",(long)components.month];
        else
            str =[NSString stringWithFormat:@"%ld Months",(long)components.month];
    }else{
        
        if(components.day!=0){
            if((int)components.day==1)
                str =[NSString stringWithFormat:@"%ld Day",(long)components.day];
            else
                str =[NSString stringWithFormat:@"%ld Days",(long)components.day];
        }else{
            
            if (components.hour!=0) {
                if((int)components.hour==1)
                    str =[NSString stringWithFormat:@"%ld Hour",(long)components.hour];
                else
                    str =[NSString stringWithFormat:@"%ld Hours",(long)components.hour];
            }else{
                
                if (components.minute!=0) {
                    if((int)components.minute==1)
                        str =[NSString stringWithFormat:@"%ld Minuete",(long)components.minute];
                    else
                        str =[NSString stringWithFormat:@"%ld Minuetes",(long)components.minute];
                }else{
                    
                    if((int)components.second==1)
                        str =[NSString stringWithFormat:@"%ld Second",(long)components.second];
                    else
                        str =[NSString stringWithFormat:@"%ld Seconds",(long)components.second];
                }
            }
        }
    }
    self.text = [NSString stringWithFormat:@" ⌚ %@ Ago",str];
}


@end
