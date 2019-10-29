//
//  UINavigationController+pd_transition.m
//  导航平滑过渡测试
//
//  Created by Lemonade on 2018/10/18.
//  Copyright © 2018年 Lemonade. All rights reserved.
//

#import "UINavigationController+pd_transition.h"
#import "UIViewController+pd_transition.h"
#import <objc/runtime.h>

@implementation UINavigationController (pd_transition)
+ (void)load {
    //    [super load];
    [self swizzleMethodWithClass:self originMethodSEL:NSSelectorFromString(@"_updateInteractiveTransition:") swizzledMethodSEL:NSSelectorFromString(@"pd_updateInteractiveTransition:")];
    [self swizzleMethodWithClass:self originMethodSEL:@selector(popViewControllerAnimated:) swizzledMethodSEL:@selector(pd_popViewControllerAnimated:)];
}

- (UIViewController *)pd_popViewControllerAnimated:(BOOL)animated {
    UIViewController *popVc =  [self pd_popViewControllerAnimated:animated];
    if(self.viewControllers.count <= 0){
        return popVc;
    }
    UIViewController *topVC = [self.viewControllers lastObject];
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coordinator = topVC.transitionCoordinator;
        //监听手势返回的交互改变,如手势滑动过程当中松手就会回调block
        if (coordinator != nil) {
            if (@available(iOS 10.0, *)) {
                [coordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
                    [self dealNavBarChangeAction:context];
                }];
            } else {
                [coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealNavBarChangeAction:context];
                }];
            }
        }
    }
    return popVc;
}
- (void)dealNavBarChangeAction:(id<UIViewControllerTransitionCoordinatorContext>)context {
    if ([context isCancelled]) {// 取消了(还在当前页面)
        //根据剩余的进度来计算动画时长xa_changeNavBarAlpha
        CGFloat animdDuration = [context transitionDuration] * [context percentComplete];
        CGFloat fromVCAlpha   = [context viewControllerForKey:UITransitionContextFromViewControllerKey].pd_navigationBarAlpha;
        [UIView animateWithDuration:animdDuration animations:^{
            [self pd_changeNavigationBarAlpha:fromVCAlpha];
        }];
        
    } else {// 自动完成(pop到上一个界面了)
        
        CGFloat animdDuration = [context transitionDuration] * (1 -  [context percentComplete]);
        CGFloat toVCAlpha     = [context viewControllerForKey:UITransitionContextToViewControllerKey].pd_navigationBarAlpha;
        [UIView animateWithDuration:animdDuration animations:^{
            [self pd_changeNavigationBarAlpha:toVCAlpha];
        }];
    };
}

- (void)pd_changeNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    NSMutableArray *barSubViews = [NSMutableArray array];
    for (UIView *view in self.navigationBar.subviews) {
        if (![view isMemberOfClass:[UIView class]]) {
            [barSubViews addObject:view];
        }
    }
    Ivar  backgroundOpacityVar =  class_getInstanceVariable([UINavigationBar class], "__backgroundOpacity");
    if(backgroundOpacityVar){
        [self.navigationBar setValue:@(navigationBarAlpha) forKey:@"__backgroundOpacity"];
    }
    UIView *backgroundView = barSubViews.firstObject;
    backgroundView.alpha = navigationBarAlpha;
}
+ (void)swizzleMethodWithClass:(Class)class  originMethodSEL:(SEL)originMethodSEL swizzledMethodSEL:(SEL)swizzledMethodSEL {
    Method originMethod = class_getInstanceMethod(class, originMethodSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledMethodSEL);
    BOOL success = class_addMethod(class, method_getName(originMethod), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, method_getName(swizzledMethod), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}
- (void)pd_updateInteractiveTransition:(CGFloat)percentComplete{
    //    NSLog(@"进度: %f", percentComplete);
    [self pd_updateInteractiveTransition:percentComplete];
    UIViewController *topVC = self.topViewController;
    if(topVC){
        //通过transitionCoordinator拿到转场的两个控制器上下文信息
        id <UIViewControllerTransitionCoordinator> coordinator =  topVC.transitionCoordinator;
        if(coordinator != nil){
            //拿到源控制器和目的控制器的透明度(每个控制器都单独保存了一份)
            CGFloat fromVCAlpha  = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey].pd_navigationBarAlpha;
            CGFloat toVCAlpha    = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey].pd_navigationBarAlpha;
            //再通过源,目的控制器的导航条透明度和转场的进度(percentComplete)计算转场时导航条的透明度
            CGFloat newAlpha = fromVCAlpha + ((toVCAlpha - fromVCAlpha ) * percentComplete);
            //这里不要直接去修改控制器navBarAlpha属性,会影响目的控制器的navBarAlpha的数值
//            NSLog(@"新的透明度: %f", newAlpha);
            [self pd_changeNavigationBarAlpha:newAlpha];
        }
    }
}
@end
