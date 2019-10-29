//
//  ColorMacros.h
//  PDKit
//
//  Created by Lemer on 2018/3/30.
//  Copyright © 2018年 Lemer. All rights reserved.
//  色值宏定义
//
// 最新修改时间:  2019/6/11       修改人:  Lemer

#ifndef ColorMacros_h
#define ColorMacros_h

/*------------------------ 基本宏配置 ------------------------*/

//普通(十进制)RGB颜色, 默认不透明
#define kRGB(r,g,b)                      RGBA(r,g,b,1.0f)
//普通(十进制)RGB颜色, 可以指定透明度
#define kRGBA(r,g,b,a)                   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// 使用十六进制颜色, 默认不透明
#define kRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 使用十六进制颜色, 可以指定不透明度
#define kRGBAHex(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/*------------------------ 基本宏配置 ------------------------*/




/*------------------------ 一些自定义的默认颜色 ------------------------*/


// 导航背景色
#define PD_NAVIGATION_BACKGROUNDCOLOR       kRGBHex(0xEC304C)
// 视图背景色
#define PD_VIEW_BACKGROUND_COLOR            kRGBHex(0xF5F6FA)
// 导航分割线颜色
#define PD_NAV_SEPARATOR_COLOR              kRGBHex(0xCDCED3)
// 普通分割线颜色
#define PD_NORMAL_SEPARATOR_COLOR           kRGBHex(0xE5E5E5)


// 主-蓝色
#define PD_MAIN_BLUE_COLOR                  kRGBHex(0x87CEFA)
// 文字-黑色
#define PD_TEXT_BLACK_COLOR                 kRGBHex(0x555555)
// 文字-灰色
#define PD_TEXT_GRAY_COLOR                  kRGBHex(0xBBBBBB)




/*------------------------ 一些自定义的默认颜色 ------------------------*/


#endif /* ColorMacros_h */
