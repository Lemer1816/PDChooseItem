//
//  DataHandleMacros.h
//  PDKit
//
//  Created by Lemer on 2018/3/30.
//  Copyright © 2018年 Lemer. All rights reserved.
//  数据处理宏定义
//
// 最新修改时间:  2019/6/11       修改人:  Lemer

#ifndef DataHandleMacros_h
#define DataHandleMacros_h


//判断是否为空
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
// 判断是否为null
#define IsNull(_ref)    ([(_ref) isEqual:[NSNull null]])
// 判断是否为number
#define IsNumber(_ref)  ([(_ref) isKindOfClass:[NSNumber class]])
// 判断是否为string
#define IsString(_ref)   ([(_ref) isKindOfClass:[NSString class]])
// 判断是否为dictionary
#define IsDictionary(_ref)  ([(_ref) isKindOfClass:[NSDictionary class]])
// 判断是否为array
#define IsArray(_ref)   ([(_ref) isKindOfClass:[NSArray class]])



// 是否为null
#define SURE_STR_NOT_NULL(x) ((x) == nil || [(x) isEqualToString:@"null"] ? @"" : (x))
// 是否为nil
#define SURE_STR_NOT_NIL(x) ((x) == nil || [(x) isEqualToString:@""] ? @"" : (x))

#define GetIntegerFromDict(_dict,_name,_defValue) ( (_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] integerValue])

#define GetFloatFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] doubleValue])

#define GetStringFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil || [_dict[_name] isEqual:[NSNull null]] ) ? _defValue : [NSString stringWithFormat:@"%@",[_dict objectForKey:_name]])

#define GetDictionaryFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [_dict objectForKey:_name])

#define GetDateFromDict(_dict,_name,_defValue) ((_dict == nil || [_dict objectForKey:_name] == nil) ? _defValue : [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[_dict objectForKey:_name]] doubleValue]])

#endif /* DataHandleMacros_h */
