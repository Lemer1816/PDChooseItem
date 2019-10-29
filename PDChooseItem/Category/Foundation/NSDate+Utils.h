//
//  NSDate+Utils.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
/** 时间转化, string -> date */
+ (NSDate *)dateWithString:(NSString *)string dateFormat:(NSString *)dateFormat;
/** date -> string */
- (NSString *)stringWithFormat:(NSString *)format;
/*
 计算两个日期之间的天数
 */
+ (NSInteger)daysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
/** 比较两个日期大小 */
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
+ (NSInteger)compareOneDayString:(nonnull NSString *)oneDay withAnotherDayString:(nullable NSString *)anotherDay;

@end
