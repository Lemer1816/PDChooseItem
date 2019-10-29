//
//  UIView+Utils.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)


/**
 圆角值
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

+ (CGRect)getAbsoluteFrameFromOriginView:(UIView * __nonnull)originView;

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


/**
 *  添加边角线(类似相机框那种)
 *
 *  @param  lineColor    线条颜色, 默认为红色
 *  @param  lineWidth    线条宽度, 默认为2
 *  @param  lineLength   线条长度, 默认为视图宽高较小者的1/6, 超出其1/3自动设为默认
 *
 */
- (void)addCornerLinesWithColor:(nullable UIColor *)lineColor
                      lineWidth:(CGFloat)lineWidth
                     lineLength:(CGFloat)lineLength;




@end

@interface UIView (Frame)

/** 视图的x坐标 */
@property (nonatomic, readwrite, assign) CGFloat x;
/** 视图的y坐标 */
@property (nonatomic, readwrite, assign) CGFloat y;
/** 视图的宽度 */
@property (nonatomic, readwrite, assign) CGFloat width;
/** 视图的高度 */
@property (nonatomic, readwrite, assign) CGFloat height;
/** 视图的尺寸(宽高) */
@property (nonatomic, readwrite, assign) CGSize size;

@property (nonatomic, readonly, assign) CGFloat minX;
@property (nonatomic, readonly, assign) CGFloat midX;
@property (nonatomic, readonly, assign) CGFloat maxX;

@property (nonatomic, readonly, assign) CGFloat minY;
@property (nonatomic, readonly, assign) CGFloat midY;
@property (nonatomic, readonly, assign) CGFloat maxY;

@end


typedef void(^tapAction)(void);
@interface UIView (Tap)<UIGestureRecognizerDelegate>

/**
 单击事件

 @param block 事件回调
 */
- (void)tapBlock:(nullable tapAction)block;

@end

