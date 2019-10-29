//
//  NSObject+MJExtension.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface NSObject (MJExtension)
/** 将原始数据(字典或者数组)解析 */
+ (id)parse:(id)responseObj;
/** 添加原始数据中存在的类名 */
+ (NSDictionary *)objectClassInArray;
/** 将属性名与字段名做映射 */
+ (NSDictionary *)replacedKeyFromPropertyName;
@end
