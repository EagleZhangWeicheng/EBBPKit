//
//  ELConfig.h
//  EBBPKit
//
//  工程基础配置
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ELBackConfig.h"

@interface ELConfig : NSObject
@property(nonatomic)CGFloat navBarTitleFontSize; //全局导航栏字体大小默认 17
@property(nonatomic,strong)UIColor *navBarTitleColor;//全局导航栏字体颜色 默认 333333
@property(nonatomic,strong)UIImage *navBarBGImage;//全局导航栏背景图 默认 无
@property(nonatomic,strong)UIImage *navBarShawdowImage;//全局导航栏背景图 默认 无
@property(nonatomic) BOOL navBarTranslucent; //是否透明 默认yes 为不不透明
@property(nonatomic,strong) UIColor *navBarTintColor; //navbar的叠加颜色 默认白色

@property(nonatomic,strong)ELBackConfig *backConfig; //返回配置
+(ELConfig*)shareConfig;

-(void)config;
@end
