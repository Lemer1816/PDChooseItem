//
//  UtilsMacros.h
//  PDKit
//
//  Created by Lemer on 2018/3/30.
//  Copyright © 2018年 Lemer. All rights reserved.
//  工具宏定义
//
// 最新修改时间:  2019/6/11       修改人:  Lemer

#ifndef UtilsMacros_h
#define UtilsMacros_h

// 重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...)  fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...)  nil
#endif

// 获取keyWindow(当前window)
#define KEY_WINDOW          ([UIApplication sharedApplication].keyWindow)
// 当前app代理
#define APP_DELEGETE        ((AppDelegate*)[[UIApplication sharedApplication] delegate])

// app名称
#define APP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
// app版本
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// appID
#define APP_ID              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]



// 系统当前版本号
#define SYSTEM_VERSION      [UIDevice currentDevice].systemVersion
// 系统当前名称(e.g. iOS, macOS, tvOS, watchOS)
#define SYSTEM_NAME         [UIDevice currentDevice].systemName



// 系统版本大于iOS 8
#define iOS8     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
// 系统版本大于iOS 9
#define iOS9     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
// 系统版本大于iOS 10
#define iOS10    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")

// iOS 11之后新增@available语法糖, apple建议使用
// 系统版本大于iOS 11
#define iOS11    (@available(iOS 11.0, *))
// 系统版本大于iOS 12
#define iOS12    (@available(iOS 12.0, *))


// 大于系统版本号
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
// 大于或等于系统版本号
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
// 等于系统版本号
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
// 小于或等于系统版本号
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
// 小于系统版本号
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

// UIImage设置图片
#define kImageName(name) [UIImage imageNamed:name]
// 加载项目中的资源图片
#define LoadImageWithType(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
// 加载xib
#define LoadNib(x) [[NSBundle mainBundle] loadNibNamed:@(x) owner:nil options:nil][0]
// NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
// 程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)
// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])
// 角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
// 获取系统时间戳
#define GET_CURRENT_TIME [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
// masonry mas_equalTo -> equalTo
#define MAS_SHORTHAND_GLOBALS
// 归解档
#define kArchive \
- (void)encodeWithCoder:(NSCoder *)aCoder{\
unsigned int outCount = 0;\
Ivar *varList = class_copyIvarList(self.class, &outCount);\
for (int i = 0; i<outCount; i++) {\
Ivar tmpIvar = varList[i];\
const char *name = ivar_getName(tmpIvar);\
NSString *propertyName = [NSString stringWithUTF8String:name];\
id obj = [self valueForKey:propertyName];\
[aCoder encodeObject:obj forKey:propertyName];\
}\
free(varList);\
}\
- (instancetype)initWithCoder:(NSCoder *)aDecoder{\
if (self = [super init]) {\
unsigned int outCount = 0;\
Ivar *varList = class_copyIvarList(self.class, &outCount);\
for (int i = 0; i<outCount; i++) {\
Ivar tmpIvar = varList[i];\
const char *name = ivar_getName(tmpIvar);\
NSString *propertyName = [NSString stringWithUTF8String:name];\
id obj = [aDecoder decodeObjectForKey:propertyName];\
[self setValue:obj forKey:propertyName];\
}\
free(varList);\
}\
return self;\
}\



#endif /* UtilsMacros_h */



