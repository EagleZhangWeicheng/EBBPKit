//
//  NSString+EBLString.m
//  EagleBasicLib
//
//  Created by eagle
//  Copyright ©  All rights reserved.
//

#import "NSString+ELString.h"

@implementation NSString (EBLString)
#pragma mark 是否是email格式
- (BOOL)isEmailFormat{
    NSString *judgeRole = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    return [predicate evaluateWithObject:self];
}

#pragma mark 是否是手机号码格式
- (BOOL)isMobilePhoneNumFormat{
    //  14x[数据卡号段] 17xx[虚拟运营商号段]
    /**
     * 手机号码
     * 移动：134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     * 联通：130 131 132 155 156 185 186
     * 电信：133 1349[卫通] 153 180 181 189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0-27-9]|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349[卫通],153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
        } else if([regextestct evaluateWithObject:self] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark 是否身份证格式
- (BOOL)isIDCardFormat{
    if (self.length <= 0) {
        return NO;
    }
    NSString *judgeRole = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    return [predicate evaluateWithObject:self];
}

#pragma mark 是否纯数字格式
- (BOOL)isOnlyNumberFormat{
    NSString *judgeRole = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    return [predicate evaluateWithObject:self];
}

#pragma mark 是否不带符号的密码格式[有字母数字组成]
- (BOOL)isPasswordWithoutSymbolFormat{
    NSString *judgeRole = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    return [predicate evaluateWithObject:self];
}

#pragma mark 为银行卡号格式化 每隔四位添加一个空格
-(NSString *)getBankFormat;{
    NSString *tempStr=self;
    NSInteger size =(tempStr.length / 4);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++){
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4, (tempStr.length % 4))]];
    tempStr = [tmpStrArr componentsJoinedByString:@"  "];
    return tempStr;
}



@end
