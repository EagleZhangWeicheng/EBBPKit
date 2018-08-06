//
//  NSString+EBLString
//  EagleBasicLib
//
//  Created by Eagle
//  Copyright All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  提供特定格式的字符串校验
 */
@interface NSString (EBLString)

/**
 *  判断字符串是否为是否是email格式
 *
 *  @return 是否
 */
- (BOOL)isEmailFormat;

/**
 *  判断字符串是否是手机号码格式
 *
 *  @return 是否
 */
- (BOOL)isMobilePhoneNumFormat;

/**
 *  判断字符串是否是否身份证格式
 *
 *  @return 是否
 */
- (BOOL)isIDCardFormat;

/**
 *  判断字符串是否纯数字格式
 * 
 *  @return 是否
 */
- (BOOL)isOnlyNumberFormat;

/**
 *  判断字符串是否不带符号的密码格式[有字母数字组成]
 *
 *  @return 是否
 */
- (BOOL)isPasswordWithoutSymbolFormat;

/**
 *  字符串银行卡号格式化 每隔四位添加一个空格
 *
 *  @return 格式化之后的字符串
 */
-(NSString *)getBankFormat;

@end
