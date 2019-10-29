//
//  NSString+Utils.m
//  PDKit
//
//  Created by Lemonade on 2019/1/3.
//  Copyright © 2019 Lemonade. All rights reserved.
//

#import "NSString+Utils.h"
#import <objc/runtime.h>

@implementation NSString (Utils)


/**
 *  @brief  固定电话区号格式化（将形如 01085792889 格式化为 010-85792889）
 *
 *  @return 返回格式化后的号码（形如 010-85792889）
 */
- (NSString *)areaCodeFormat
{
    // 先去掉两边空格
    NSMutableString *value = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    // 先匹配是否有连字符/空格，如果有则直接返回
    NSString *regex = @"^0\\d{2,3}[- ]\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if([predicate evaluateWithObject:value]){
        // 替换掉中间的空格
        return [value stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    
    // 格式化号码 三位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_threeDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:3];
        return value;
    }
    
    
    // 格式化号码 四位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_fourDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:4];
        return value;
    }
    
    return nil;
}

/**
 *  @brief  验证固定电话区号是否正确（e.g. 010正确，030错误）
 *
 *  @return 返回固定电话区号是否正确
 */
- (BOOL)isAreaCode
{
    
    NSString *regex = [NSString stringWithFormat:@"^%@|%@$",[self regex_areaCode_threeDigit],[self regex_areaCode_fourDigit]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:self]){
        return YES;
    }
    
    return NO;
}


/**
 *  @brief  获取三位数区号的正则表达式（三位数区号形如 010）
 */
- (NSString*)regex_areaCode_threeDigit
{
    return @"010|02[0-57-9]";
}
/**
 *  @brief  获取四位数区号的正则表达式（四位数区号形如 0311）
 */
- (NSString*)regex_areaCode_fourDigit
{
    // 03xx
    NSString *fourDigit03 = @"03([157]\\d|35|49|9[1-68])";
    // 04xx
    NSString *fourDigit04 = @"04([17]\\d|2[179]|[3,5][1-9]|4[08]|6[4789]|8[23])";
    // 05xx
    NSString *fourDigit05 = @"05([1357]\\d|2[37]|4[36]|6[1-6]|80|9[1-9])";
    // 06xx
    NSString *fourDigit06 = @"06(3[1-5]|6[0238]|9[12])";
    // 07xx
    NSString *fourDigit07 = @"07(01|[13579]\\d|2[248]|4[3-6]|6[023689])";
    // 08xx
    NSString *fourDigit08 = @"08(1[23678]|2[567]|[37]\\d)|5[1-9]|8[3678]|9[1-8]";
    // 09xx
    NSString *fourDigit09 = @"09(0[123689]|[17][0-79]|[39]\\d|4[13]|5[1-5])";
    
    return [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",fourDigit03,fourDigit04,fourDigit05,fourDigit06,fourDigit07,fourDigit08,fourDigit09];
    
}
@end

@implementation NSString (Encrypt)

+ (NSString *)md5:(NSString *)plainText {
    const char *cStr = [plainText UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    // MD5声明
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultStr appendFormat:@"%02x", digest[i]];
    return  resultStr;
}
+ (NSString *)sha1:(NSString *)plainText {
    const char *cstr = [plainText cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:plainText.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [resultStr appendFormat:@"%02x", digest[i]];
    }
    return resultStr;
}
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString *)key {

    const void *vplainText;
    size_t plainTextBufferSize;

    if (encryptOrDecrypt == kCCDecrypt) {   // 解密
        NSData *decryptData = [[NSData alloc] initWithBase64EncodedString:plainText options:NSDataBase64DecodingIgnoreUnknownCharacters];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    } else {  // 加密
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;

    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // ECB模式其实用不到偏移量, 然而貌似OC中只有ECB加密...
    NSString *initVec = @"p2p_s2iv";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];

    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey, // 秘钥
                       kCCKeySize3DES,
                       vinitVec, // 偏移量,
                       vplainText, // 明文,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);


    NSString *resultStr = nil;
    NSData *tmpData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    if (encryptOrDecrypt == kCCDecrypt) {   // 解密
        resultStr = [[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
    } else {    // 加密
        resultStr = [tmpData base64EncodedStringWithOptions:0];
    }
    return resultStr;
}
+ (BOOL)isEmpty:(NSString *)str {
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    }else {
        return NO;
        //没有空格
    }
}
@end

static const void *paragraphStyleKey = &paragraphStyleKey;

@implementation NSString (Text)

- (CGFloat)heightWithFont:(UIFont *)font
                    width:(CGFloat)width
   hasFirstLineHeadIndent:(BOOL)hasFirstLineHeadIndent {
    return [self heightWithFont:font width:width hasFirstLineHeadIndent:hasFirstLineHeadIndent attributedDictionary:nil];
}
- (CGFloat)heightWithFont:(nullable UIFont *)font
                    width:(CGFloat)width
     attributedDictionary:(nullable NSDictionary *)attributedDictionary {
    return [self heightWithFont:font width:width hasFirstLineHeadIndent:YES attributedDictionary:attributedDictionary];
}
- (CGFloat)heightWithFont:(UIFont *)font
                    width:(CGFloat)width
   hasFirstLineHeadIndent:(BOOL)hasFirstLineHeadIndent
     attributedDictionary:(NSDictionary *)attributedDictionary {
    if (!font) {    // 没有自定义字体,则使用系统默认
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    if (width <= 0) {   // 宽度不大于0,使用屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
    }
    if (!attributedDictionary) {
        attributedDictionary = [self attributedDictionaryWithFont:font hasFirstLineHeadIndent:hasFirstLineHeadIndent];
    }
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributedDictionary context:nil].size;
    return size.height;
}
- (NSDictionary *)attributedDictionaryWithFont:(UIFont *)font
                        hasFirstLineHeadIndent:(BOOL)hasFirstLineHeadIndent {
    //首行缩进
    self.pargraphStyle.firstLineHeadIndent = hasFirstLineHeadIndent ? font.lineHeight*2 : 0.0;
    NSDictionary *dic = @{
                          NSFontAttributeName: font,
                          NSParagraphStyleAttributeName: self.pargraphStyle,
                          NSKernAttributeName: @1.5f,
                          NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]
                          };
    return dic;
}
- (void)setPargraphStyle:(NSMutableParagraphStyle *)pargraphStyle {
    objc_setAssociatedObject(self, paragraphStyleKey, pargraphStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableParagraphStyle *)pargraphStyle {
    NSMutableParagraphStyle *style = objc_getAssociatedObject(self, paragraphStyleKey);
    if (!style) {
        style = [[NSMutableParagraphStyle alloc] init];
        // 折行方式
        style.lineBreakMode = NSLineBreakByCharWrapping;
        // 对齐方式--左右对齐
        style.alignment = NSTextAlignmentJustified;
        // 行间距
        style.lineSpacing = 5.0;
        // 判断每行最后一个单词是否被截断,数值介于0.0~1.0,越靠近1.0被截断的几率越大
        style.hyphenationFactor = 0.0;
        // 首行缩进
        style.firstLineHeadIndent = 0.0;
        // 整段缩进(左)
        style.headIndent = 0.0;
        // 整段缩进(正值--文本所要显示的宽度,负值--右侧缩进)
        style.tailIndent = 0.0;
        // 段落前间距(暂时发现\n存在时生效)
        style.paragraphSpacingBefore = 0.0;
        // 段落后间距(暂时发现\n存在时生效)
        style.paragraphSpacing = 0.0;
        //    // 行间距(是默认行间距的多少倍)
        //    paragraphStyle.lineHeightMultiple = 1.6;
    }
    
    return style;
}

@end
