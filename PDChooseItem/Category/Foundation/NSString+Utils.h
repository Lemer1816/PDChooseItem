//
//  NSString+Utils.h
//  PDKit
//
//  Created by Lemonade on 2019/1/3.
//  Copyright © 2019 Lemonade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utils)

@end


@interface NSString (Encrypt)
/** MD5加密 */
+ (NSString *)md5:(nonnull NSString *)plainText;
/** sha1加密 */
+ (NSString *)sha1:(nonnull NSString *)plainText;
/** 3DES加密
 *
 *  @param  plainText   明文/密文字符串
 *  @param  encryptOrDecrypt    操作模式(加密/解密)
 *  @param  key 密码
 *
 *  @return 加密/解密后的字符串
 *
 */
+ (NSString *)tripleDES:(nonnull NSString *)plainText
       encryptOrDecrypt:(CCOperation)encryptOrDecrypt
                    key:(nonnull NSString *)key;
/** 判断字符串是否为空 */
+ (BOOL)isEmpty:(NSString *)str;

@end

@interface NSString (Text)
/** 段落样式 */
@property (nonatomic, readwrite, strong) NSMutableParagraphStyle *pargraphStyle;

/** 计算文本高度(根据字体, 宽度, 是否首行缩进)
 *
 *  @param   font    文本字体
 *  @param   width    文本所要显示的宽度
 *  @param   hasFirstLineHeadIndent    是否首行缩进
 *
 *  @return  计算后的文本高度
 *
 */
- (CGFloat)heightWithFont:(nullable UIFont *)font
                    width:(CGFloat)width
   hasFirstLineHeadIndent:(BOOL)hasFirstLineHeadIndent;
/** 计算文本高度(根据字体, 宽度, 富文本字典)
 *
 *  @param   font    文本字体
 *  @param   width    文本所要显示的宽度
 *  @param   attributedDictionary    富文本字典
 *
 *  @return  计算后的文本高度
 *
 */
- (CGFloat)heightWithFont:(nullable UIFont *)font
                    width:(CGFloat)width
      attributedDictionary:(nullable NSDictionary *)attributedDictionary;
/** 计算文本高度(根据字体, 宽度, 是否首行缩进, 富文本字典)
 *
 *  @param   font    文本字体
 *  @param   width    文本所要显示的宽度
 *  @param   hasFirstLineHeadIndent    是否首行缩进
 *  @param   attributedDictionary    富文本字典
 *
 *  @return  计算后的文本高度
 *
 */
- (CGFloat)heightWithFont:(nullable UIFont *)font
                    width:(CGFloat)width
   hasFirstLineHeadIndent:(BOOL)hasFirstLineHeadIndent
     attributedDictionary:(nullable NSDictionary *)attributedDictionary;

@end

NS_ASSUME_NONNULL_END
