//
//  NSObject+Utils.m
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)
+ (NSDate *)dateWithString:(NSString *)string dateFormat:(NSString *)dateFormat{
    if ([string containsString:@"T"]) {
        string = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    if ([string containsString:@"Z"]) {
        string = [string stringByReplacingOccurrencesOfString:@"Z" withString:@""];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter dateFromString:string];
}
+ (NSDate *)dateWithString:(NSString *)string dateFormatType:(DateFormatType)dateFormatType {
    if ([string containsString:@"T"]) {
        string = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    if ([string containsString:@"Z"]) {
        string = [string stringByReplacingOccurrencesOfString:@"Z" withString:@""];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (dateFormatType == DateFormatTypeFull) {
        dateFormatter.dateFormat = @"yyyy:MM:dd HH:mm:ss";
    } else if (dateFormatType == DateFormatTypeYear) {
        dateFormatter.dateFormat = @"yyyy:MM:dd";
    } else {
        dateFormatter.dateFormat = @"HH:mm:ss";
    }
    return [dateFormatter dateFromString:string];
}

+ (NSString *)textStringWithDate:(NSDate *)date{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:date];
    if (timeInterval < 60) { //1分钟内
        return @"刚刚";
    } else if (timeInterval < 3600) {  //1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (NSInteger)(timeInterval/60)];
    } else if (timeInterval < 3600*24) {  //1天内
        return [NSString stringWithFormat:@"%ld小时前", (NSInteger)(timeInterval/3600)];
    }else if (timeInterval < 3600*48) {  //2天内
        return @"昨天";
    } else {  //2天以上
        NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:date];
        NSInteger month = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:date];
        NSInteger day = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:date];
        return [NSString stringWithFormat:@"%ld.%ld.%ld", year, month, day];
    }
}
+ (NSString *)stringWithCount:(NSInteger)count suffix:(NSString *)suffix {
    if (count < 10000) {
        return [NSString stringWithFormat:@"%ld%@", count, suffix];
    } else {
        
        CGFloat newCount = count*1.0/10000;
        return [NSString stringWithFormat:@"%.1lf万%@", newCount, suffix];
    }
}
+ (NSString *)stringCovertedByFullWidthString:(NSString *)fullWidthString{
    NSMutableString *convertedString = [fullWidthString mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false);
    return [convertedString copy];
}
+ (NSURL *)validURLByEscapeInvalidCharactersWithString:(NSString *)str {
    NSString *escapeStr = @"";
    NSCharacterSet *allowChar = [[NSCharacterSet characterSetWithCharactersInString:escapeStr] invertedSet];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:allowChar]];
    return url;
}
- (BOOL)isValidURL {
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

//iOS判断手机号码格式是否正确
+ (BOOL)validMobile:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    } else {
        //移动号段正则表达式
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //联通号段正则表达式
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //电信号段正则表达式
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
    
}



@end
