//
//  UIButton+Countdown.m
//  FireCicada
//
//  Created by weedx on 2018/8/16.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "UIButton+Countdown.h"

@interface UIButton ()

/**
 资源回收对象
 */
@property (nonatomic, strong) RACDisposable *dispoable;

@end

static NSString *const key = @"dispoable";

static const void *countingKey = &countingKey;

@implementation UIButton (Countdown)

@dynamic dispoable;

- (void)setDispoable:(RACDisposable *)dispoable {
    objc_setAssociatedObject(self, &key, dispoable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACDisposable *)dispoable {
    return objc_getAssociatedObject(self, &key);
}
- (void)setCounting:(NSString *)counting {
    objc_setAssociatedObject(self, &countingKey, counting, OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)counting {
    return objc_getAssociatedObject(self, &countingKey);
}

- (void)countDownWithSeconds:(NSInteger)seconds {
    //弱引用避免循环引用
    @weakify(self)
    self.counting = @"1";
    __block NSInteger remianTime = seconds;
    //这个就是RAC中的GCD
    self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        //强引用避免异步操作时self已经被释放
        @strongify(self)
        //时间自减
        remianTime --;
        //设置按钮标题
        NSString * title = [NSString stringWithFormat:@"%zds后重新获取",remianTime];
        [self setTitle:title forState: UIControlStateDisabled];
        
        //设置按钮交互性
        self.enabled = (remianTime == 0) ? YES : NO;
        if (remianTime == 0) {
            self.counting = @"1";
            //倒计时结束回收资源
            [self.dispoable dispose];
        }
    }];
}

@end
