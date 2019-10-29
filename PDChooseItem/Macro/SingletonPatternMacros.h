//
//  SingletonPatternMacros.h
//  PDKit
//
//  Created by Lemer on 2018/3/30.
//  Copyright © 2018年 Lemer. All rights reserved.
//  单例宏定义
//
// 最新修改时间:  2019/6/11       修改人:  Lemer

#ifndef SingletonPatternMacros_h
#define SingletonPatternMacros_h

// @interface
#define singleton_interface(name) \
+ (instancetype)shared##name;

// @implementation
#define singleton_implementation(name) \
static id _instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(struct _NSZone *)zone {\
    return _instance;\
}\
- (id)mutableCopyWithZone:(NSZone *)zone {\
    return _instance;\
}\
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc] init];\
    });\
    return _instance;\
} \


#endif /* SingletonPatternMacros_h */
