//
//  UIViewController+pd_transition.m
//  导航平滑过渡测试
//
//  Created by Lemer on 2018/10/18.
//  Copyright © 2018年 Lemer. All rights reserved.
//

#import "UIViewController+pd_transition.h"

#import <objc/runtime.h>

static const void *barAlphaKey = &barAlphaKey;

@implementation UIViewController (pd_transition)
+ (void)load {
    [self swizzleMethodWithClass: self originMethodSEL:@selector(viewDidLoad) swizzledMethodSEL:@selector(pd_viewDidLoad)];
    [self swizzleMethodWithClass:self originMethodSEL:@selector(viewWillAppear:) swizzledMethodSEL:@selector(pd_viewWillAppear:)];
}

- (void)pd_viewDidLoad {
    self.pd_navigationBarAlpha = 1.0;
    [self pd_viewDidLoad];
//    [self.navigationController pd_changeNavigationBarAlpha:self.pd_navigationBarAlpha];
}
- (void)pd_viewWillAppear:(BOOL)animated {
    [self pd_viewWillAppear:animated];
    [self.navigationController pd_changeNavigationBarAlpha:self.pd_navigationBarAlpha];
    
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
#pragma mark - Getter & Setter
- (void)setPd_navigationBarAlpha:(CGFloat)pd_navigationBarAlpha {
    // 比1小, 比0大
    pd_navigationBarAlpha = MAX(0.0, MIN(1.0, pd_navigationBarAlpha));
    objc_setAssociatedObject(self, barAlphaKey, @(pd_navigationBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self.navigationController pd_changeNavigationBarAlpha:self.pd_navigationBarAlpha];
}
- (CGFloat)pd_navigationBarAlpha {
    return [objc_getAssociatedObject(self, barAlphaKey) floatValue];
}
@end
