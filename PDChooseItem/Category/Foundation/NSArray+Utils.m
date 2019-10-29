//
//  NSArray+Utils.m
//  HuzhouTourSupervise
//
//  Created by Wynter on 2018/5/2.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "NSArray+Utils.h"

@implementation NSArray (Utils)

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

- (NSString*)stringWithIndex:(NSUInteger)index {
    id value = [self objectOrNilAtIndex:index];
    if (value == nil || value == [NSNull null]) {
        return @"";
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

@end
