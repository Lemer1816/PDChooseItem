//
//  UIControl+Event.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ControlClickBlock)(UIControl *sender);

@interface UIControl (Event)

@property (nonatomic, copy) ControlClickBlock controlClickBlock;
/** UIControl及其子类点击事件block */
- (void)addControlClickBlock:(ControlClickBlock)controlClickBlock
            forControlEvents:(UIControlEvents)controlEvents;

@end
