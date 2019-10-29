//
//  DimensMacros.h
//  PDKit
//
//  Created by Lemer on 2018/3/30.
//  Copyright © 2018年 Lemer. All rights reserved.
//  尺寸宏定义
//
// 最新修改时间:  2019/6/11       修改人:  Lemer

#ifndef DimensMacros_h
#define DimensMacros_h


// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 屏幕rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

// 状态栏高度
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
// 导航栏高度
#define kNavigationBarHeight (44.f)
// 状态栏+导航高度
#define kTopBarHeight       (kStatusBarHeight + kNavigationBarHeight)
// tabBar菜单的高度
#define kBottomBarHeight    (49.f + kBottomWhiteHeight)
// iPhone X系列底部留白高度
#define kBottomWhiteHeight ((IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS_MAX) ? 34.f : 0)


// 字体大小
#define FONT(_size)     [UIFont systemFontOfSize:_size]
#define PF_FONT(_size)     [UIFont fontWithName:@"PingFang SC" size:_size]

// 判断是否是iPhone X(Xs)
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone Xr
#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone Xs Max
#define IS_IPHONE_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

// cell默认高度(系统尺寸)
#define kCellDefaultHeight      (44.f)


// View 坐标(x,y)和宽高(width,height)
#define ViewPositionX(v)                 (v).frame.origin.x
#define ViewPositionY(v)                 (v).frame.origin.y
#define ViewWidth(v)                     (v).frame.size.width
#define ViewHeight(v)                    (v).frame.size.height

#define MinFrameX(v)                    CGRectGetMinX((v).frame)
#define MinFrameY(v)                    CGRectGetMinY((v).frame)

#define MidFrameX(v)                    CGRectGetMidX((v).frame)
#define MidFrameY(v)                    CGRectGetMidY((v).frame)

#define MaxFrameX(v)                    CGRectGetMaxX((v).frame)
#define MaxFrameY(v)                    CGRectGetMaxY((v).frame)

// 屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

// 获取安全区范围
#define VIEW_SAFE_AREA_INSETS(view)        ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})



#endif /* DimensMacros_h */
