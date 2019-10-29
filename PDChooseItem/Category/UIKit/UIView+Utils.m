//
//  UIView+Utils.m
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "UIView+Utils.h"
#import <objc/runtime.h>

@implementation UIView (Utils)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

+ (CGRect)getAbsoluteFrameFromOriginView:(UIView *)originView {
    
    CGFloat absX = 0;
    CGFloat absY = 0;
    UIView *tmpView = originView;
    
    while (tmpView.superview != nil) {
        
        CGRect frame = tmpView.frame;
        absX += frame.origin.x;
        absY += frame.origin.y;
        
        tmpView = tmpView.superview;
        // 由于ScrollView存在contentOffset,因此对于ScrollView及其子类要做特殊判断
        if ([tmpView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scView = (UIScrollView *)tmpView;
            absX -= scView.contentOffset.x;
            absY -= scView.contentOffset.y;
        }
    }
    absX += tmpView.frame.origin.x;
    absY += tmpView.frame.origin.y;
    
    return CGRectMake(absX, absY, originView.frame.size.width, originView.frame.size.height);
    
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}
- (void)addCornerLinesWithColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth lineLength:(CGFloat)lineLength {
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    // 线条颜色
    lineLayer.strokeColor = (lineColor && lineColor != [UIColor clearColor]) ? lineColor.CGColor : [UIColor redColor].CGColor;
    // 线条宽度
    lineLayer.lineWidth = lineWidth > 0 ? lineWidth : 2;
    // 每段长度
    // 就是长度如果大于0或者小于视图宽高中较小者的1/3,则不变,否则取宽高较小者的1/6
    lineLength = (lineLength > 0 && lineLength < ((self.bounds.size.width < self.bounds.size.height ? self.bounds.size.width : self.bounds.size.height)/3)) ? lineLength : ((self.bounds.size.width < self.bounds.size.height ? self.bounds.size.width : self.bounds.size.height)/6);
    // 填充色(所围成的)
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 左上角
    CGPoint leftUpPoint = CGPointMake(0, 0);
    [linePath moveToPoint:CGPointMake(leftUpPoint.x, leftUpPoint.y+lineLength)];
    [linePath addLineToPoint:leftUpPoint];
    [linePath addLineToPoint:CGPointMake(leftUpPoint.x+lineLength, leftUpPoint.y)];
    // 右上角
    CGPoint rightUpPoint = CGPointMake(self.bounds.size.width, 0);
    [linePath moveToPoint:CGPointMake(rightUpPoint.x-lineLength, rightUpPoint.y)];
    [linePath addLineToPoint:rightUpPoint];
    [linePath addLineToPoint:CGPointMake(rightUpPoint.x, rightUpPoint.y+lineLength)];
    // 右下角
    CGPoint rightDownPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    [linePath moveToPoint:CGPointMake(rightDownPoint.x, rightDownPoint.y-lineLength)];
    [linePath addLineToPoint:rightDownPoint];
    [linePath addLineToPoint:CGPointMake(rightDownPoint.x-lineLength, rightDownPoint.y)];
    // 左下角
    CGPoint leftDownPoint = CGPointMake(0, self.bounds.size.height);
    [linePath moveToPoint:CGPointMake(leftDownPoint.x+lineLength, leftDownPoint.y)];
    [linePath addLineToPoint:leftDownPoint];
    [linePath addLineToPoint:CGPointMake(leftDownPoint.x, leftDownPoint.y-lineLength)];
    
    
    lineLayer.path = linePath.CGPath;
    [self.layer addSublayer:lineLayer];
}
@end

@implementation UIView (Frame)
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midX{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxX{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
@end

@interface UIView (Tap_private)

- (void)runBlockForKey:(void *)blockKey;

- (void)setBlock:(tapAction)block forKey:(void *)blockKey;

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger) taps touches:(NSUInteger) touches selector:(SEL) selector;

- (void) addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer;

@end

@implementation UIView (Tap)

static char kTappedBlockKey;

#pragma mark -
#pragma mark Set blocks

- (void)runBlockForKey:(void *)blockKey {
    tapAction block = objc_getAssociatedObject(self, blockKey);
    if (block) block();
}

- (void)setBlock:(tapAction)block forKey:(void *)blockKey {
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -
#pragma mark When Tapped
- (void)tapBlock:(tapAction)block {
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];
    [self addRequiredToDoubleTapsRecognizer:gesture];
    
    [self setBlock:block forKey:&kTappedBlockKey];
}

- (void)viewWasTapped {
    [self runBlockForKey:&kTappedBlockKey];
}

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addGestureRecognizer:tapGesture];
    });
    return tapGesture;
}

- (void) addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
            if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
                UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
                if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
                    [recognizer requireGestureRecognizerToFail:tapGesture];
                }
            }
        }
    });
}

@end

