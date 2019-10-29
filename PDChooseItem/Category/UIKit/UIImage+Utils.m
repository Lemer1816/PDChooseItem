//
//  UIImage+Utils.m
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

// 根据色值生成image
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(0, 0)];
}
// 根据色值和大小生成image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect;
    if (size.width == 0) {
        rect = CGRectMake(0, 0, 1, 1);
    }else{
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
