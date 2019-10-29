//
//  NSArray+Utils.h
//  HuzhouTourSupervise
//
//  Created by Wynter on 2018/5/2.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (Utils)

- (id)objectOrNilAtIndex:(NSUInteger)index;
- (NSString*)stringWithIndex:(NSUInteger)index;

@end
