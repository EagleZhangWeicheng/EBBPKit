//
//  UIColor+EBColor.m
//  EagleBasicLib
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIColor+ELColor.h"

@implementation UIColor (EBLColor)
/**
 *  颜色的Hex字符串转成颜色
 *
 *  @param hexColorString 颜色hex值
 *
 *  @return hex的颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;{
    return [UIColor colorWithHexColorString:hexColorString alpha:1];
}

/**
 *  颜色的Hex字符串转成颜色
 *
 *  @param hexColorString 颜色hex值
 *  @param alpha 透明度
 *
 *  @return hex的颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(CGFloat)alpha;{
    //删除字符串中的空格
    NSString *cString = [[hexColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //字符串应该是6 －8 个字符
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    //如果开头是0X开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    //如果是＃开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    //如果这时字符串的长度不等于6，返回无色。
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    //分离红、绿、蓝 三种颜色
    NSRange range;
    range.location  = 0;
    range.length    = 2;
    
    //red
    NSString *redString     = [cString substringWithRange:range];
    
    //green
    range.location  = 2;
    NSString *greenString   = [cString substringWithRange:range];
    
    //blue
    range.location  = 4;
    NSString *blueString    = [cString substringWithRange:range];
    
    //Scan values //扫描值
    unsigned int red, green, blue;
    
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [UIColor colorWithRed:((float)red / 255.f) green:((float)green / 255.f ) blue:((float)blue / 255.f) alpha:alpha];

}

@end
