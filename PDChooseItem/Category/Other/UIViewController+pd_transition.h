//
//  UIViewController+pd_transition.h
//  导航平滑过渡测试
//
//  Created by Lemonade on 2018/10/18.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+pd_transition.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (pd_transition)

@property (nonatomic, readwrite, assign) CGFloat pd_navigationBarAlpha;

@end

NS_ASSUME_NONNULL_END
