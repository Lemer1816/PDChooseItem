//
//  NSObject+Utils.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DateFormatType) {
    // yyyy:MM:dd HH:mm:ss
    DateFormatTypeFull,
    // yyyy:MM:dd
    DateFormatTypeYear,
    // HH:mm:ss
    DateFormatTypeDay,
};

@interface NSObject (Utils)
/** 时间转化, string -> date, 手动填写格式 */
+ (NSDate *)dateWithString:(NSString *)string dateFormat:(NSString *)dateFormat;
/** 时间转化, string -> date, 提供三种枚举类型 */
+ (NSDate *)dateWithString:(NSString *)string dateFormatType:(DateFormatType)dateFormatType;
/** 根据日期得到文本日期字符串 */
+ (NSString *)textStringWithDate:(NSDate *)date;
/** 根据数字和转换类型得到字符串 */
+ (NSString *)stringWithCount:(NSInteger)count
                       suffix:(NSString *)suffix;
/** 将全角字符转换为半角字符 */
+ (NSString *)stringCovertedByFullWidthString:(NSString *)fullWidthString;
/** string -> URL, 并转换(主要是中文)非法字符 */
+ (NSURL *)validURLByEscapeInvalidCharactersWithString:(NSString *)str;

- (BOOL)isValidURL;

+ (BOOL)validMobile:(NSString *)mobile;

@end
