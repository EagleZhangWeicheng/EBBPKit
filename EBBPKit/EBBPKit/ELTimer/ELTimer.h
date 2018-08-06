//
//  EagleCountDown.h
//  EalgeBasicIOSProject
//  倒计时和定时器
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ELTimer;
typedef void (^EagleTimerCountDownBlock)(NSInteger seconds);
typedef void (^EagleTimerBlock)(ELTimer* timer);

@interface ELTimer : NSObject
- (instancetype)initCountDownByCountDownTime:(NSInteger)countDownTime //倒计时
                         eagleCountDownBlock:(EagleTimerCountDownBlock)eagleTimerCountDownBlock;

@property(nonatomic,copy) EagleTimerCountDownBlock eagleTimerCountDownBlock;


- (instancetype)initTimerTime:(NSInteger)timerTime //定时器
              eagleTimerBlock:(EagleTimerBlock)eagleTimerBlock;
@property(nonatomic,copy) EagleTimerBlock eagleTimerBlock;
@property(nonatomic)BOOL isStop; //是否停止
@property(nonatomic)float timerTime; //定时器

@end
