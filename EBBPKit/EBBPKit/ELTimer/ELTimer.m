//
//  EagleCountDown.m
//  EalgeBasicIOSProject
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ELTimer.h"

@implementation ELTimer
- (instancetype)initCountDownByCountDownTime:(NSInteger)countDownTime
                         eagleCountDownBlock:(EagleTimerCountDownBlock)eagleTimerCountDownBlock;{
    self = [super init];
    if (self) {
        self.eagleTimerCountDownBlock = eagleTimerCountDownBlock;
        __block NSInteger timeout = countDownTime; //倒计时时间
        __block typeof(self) blockself = self; //倒计时时间
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                blockself.eagleTimerCountDownBlock(timeout);
            }else{
                blockself.eagleTimerCountDownBlock(timeout);
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
    return self;
}

- (instancetype)initTimerTime:(NSInteger)timerTime //定时器
              eagleTimerBlock:(EagleTimerBlock)eagleTimerBlock;{
    self = [super init];
    if (self) {
        self.timerTime = timerTime;
        self.eagleTimerBlock = eagleTimerBlock;
        [self play];
    }
    return self;
}

-(void)play{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timerTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.isStop) {
            self.eagleTimerBlock(self);
            [self play];
        }
    });
}

@end
