//
//  UIColor+EBColor.h
//  EagleBasicLib
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EBColorHexStr(hexStr) [UIColor colorWithHexColorString:hexStr]
#define EBColorRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (EBLColor)
/**
 *  颜色的Hex字符串转成颜色
 *
 *  @param hexColorString 颜色hex值
 *
 *  @return hex的颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
 *  颜色的Hex字符串转成颜色
 *
 *  @param hexColorString 颜色hex值
 *  @param alpha 透明度
 *
 *  @return hex的颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(CGFloat)alpha;

@end
