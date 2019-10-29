//
//  UIImage+Utils.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
/**
 *  根据色值生成image
 *
 *  @param color 颜色
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  根据色值和大小生成image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;



@end
