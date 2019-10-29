//
//  UINavigationController+pd_transition.h
//  导航平滑过渡测试
//
//  Created by Lemonade on 2018/10/18.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (pd_transition)

- (void)pd_changeNavigationBarAlpha:(CGFloat)navigationBarAlpha;

@end

NS_ASSUME_NONNULL_END
