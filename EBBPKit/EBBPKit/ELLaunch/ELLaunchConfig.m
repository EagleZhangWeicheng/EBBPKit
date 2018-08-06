//
//  ELLaunchConfig.m
//  EBBPKit
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import "ELLaunchConfig.h"
@interface ELLaunchConfig()
@property(nonatomic)NSInteger showedTime; //已经显示次数
@end
@implementation ELLaunchConfig


-(void)incShowTime;{//显示一次增加一次数
    self.showedTime = self.showedTime+1;
}

-(BOOL)isCanShow{
    if (self.showedTime == self.showTime) {
        return false;
    }
    return true;
}

-(void)setShowedTime:(NSInteger)showedTime{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:showedTime] forKey:[self saveTimeNameByVersionAndBuild]];
}

- (NSInteger)showedTime{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:[self saveTimeNameByVersionAndBuild]] integerValue];
}

-(NSString*)saveTimeNameByVersionAndBuild{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@%@",app_Version,app_build];
}

@end

@implementation ELLaunchImagesConfig

@end

@implementation ELLaunchVideosConfig

@end

@implementation ELLaunchCustomViewConfig

@end

