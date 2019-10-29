//
//  UIButton+Countdown.h
//  FireCicada
//
//  Created by weedx on 2018/8/16.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Countdown)

@property (nonatomic, strong) RACDisposable *dispoable;

@property (nonatomic, readwrite, strong) NSString *counting;

/**
 倒计时功能(用于获取验证码)
 */
- (void)countDownWithSeconds:(NSInteger)seconds;

@end
