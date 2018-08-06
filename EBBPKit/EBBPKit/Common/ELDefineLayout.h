//
//  ELDefineLayout.h
//  EagleBasicLib
//
//  Created by Mac on 2018/7/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

#pragma mark - 系统版本 - 语言等
/**
 *  获取当前系统版本
 */
#define EL_IOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

//  是否高于ios7
#define EL_IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define EL_IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define EL_IOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

/**
 *  获取当前语言
 */
#define EL_Current_Language ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - 判断机型
//  判断是否4inch
#define EL_FourInch (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)

//  宏定义机型判断
#define EL_is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define EL_is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//  判断是否 Retina-4s屏、iphone5、iPad等
#define EL_is_Retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕大小
#define EL_screen_width [UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width
#define EL_screen_height [UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width
#define EL_screen_bounds [UIScreen mainScreen].bounds
#define EL_screen_size [UIScreen mainScreen].bounds.size


//设备类型
#define EL_is_W_iPhone4  (fabs((double)EL_screen_height - (double)480) < __DBL_EPSILON__)
#define EL_is_W_iPhone5  (fabs((double)EL_screen_height - (double)568) < __DBL_EPSILON__)
#define EL_is_W_iPhone6  (fabs((double)EL_screen_height - (double)667) < __DBL_EPSILON__)
#define EL_is_W_iPhone6Plus (fabs((double)EL_screen_height - (double)736) < __DBL_EPSILON__)
#define EL_is_W_iPhoneX  (fabs((double)EL_screen_height - (double)812) < __DBL_EPSILON__)


//  各型号设备
#define EL_is_iPhod ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])
#define EL_iPhone5   (EL_is_iPhone && EL_is_W_iPhone5)
#define EL_iPhone6   (EL_is_iPhone && EL_is_W_iPhone6)
#define EL_iPhone6Plus  (EL_is_iPhone && EL_is_W_iPhone6Plus)
#define EL_iPhoneX      (EL_is_iPhone && EL_is_W_iPhoneX)



#define EL_Nav_SafeAreaTopHeight     EL_is_W_iPhoneX? 88 : 64
#define EL_addjust_SafeAreaTopHeight EL_is_W_iPhoneX? 20 : 0
#define EL_Nav_SafeAreaBottomHeight  EL_is_W_iPhoneX? 83 : 49
#define EL_addjust_SafeAreaButtonHeight EL_is_W_iPhoneX? 34 : 0

