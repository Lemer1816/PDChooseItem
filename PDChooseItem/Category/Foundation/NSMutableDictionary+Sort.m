//
//  NSMutableDictionary+Sort.m
//  FireCicada
//
//  Created by weedx on 2018/8/21.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "NSMutableDictionary+Sort.h"

@implementation NSMutableDictionary (Sort)


/**
 冒泡排序

 @return 排序后的key组成的array
 */
- (NSMutableArray *)sortKeys {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.allKeys];
    for (NSUInteger i = 0; i < array.count - 1; i ++) {
        for (int j = 0; j < array.count - 1 - i; j ++) {
            NSComparisonResult result = [array[j] compare:array[j + 1] options:NSLiteralSearch];
            switch (result) {
                case NSOrderedDescending:
                {
                    [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    return array;
}

@end
