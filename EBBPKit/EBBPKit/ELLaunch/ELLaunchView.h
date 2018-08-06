//
//  ELIntroductionView.h
//  EBBPKit
//
//  首次启动介绍view或者从广告也 只是启动一次 暂时支持和本地和网络图片 以后要扩展到视频
//  视频下载基于AFNetworking
//  图片下载基于 SDWebImage
//
//  Created by Eagle on 2018/7/30.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLaunchConfig.h"
#import "ELLaunchSkipButton.h"
#import "ELLaunchVideoView.h"
@class ELLaunchView;
typedef void (^LaunchViewDidFinishBlock)(ELLaunchView *launchView);

@protocol ELLaunchDelgate <NSObject>
@optional
-(void)selectSection:(NSInteger)section launchView:(ELLaunchView*)ELLaunchView; //选择的具体哪一个模块
-(void)launchViewDidFinish:(ELLaunchView*)ELLaunchView; //消失

@end

@interface ELLaunchViewCell:UICollectionViewCell
@property(nonatomic,strong)UIImageView* imageView;     //
@property(nonatomic,strong)ELLaunchVideoView *launchVideoView;

@property(nonatomic)ELLaunchConfigType launchConfigType;
@end

@interface ELLaunchView : UIView

+(void)launchImagesWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate; //图片
+(void)launchVideosWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate; //视频
+(void)launchCustomViewsWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate; //自定义view

@property(nonatomic,copy)LaunchViewDidFinishBlock launchViewDidFinishBlock;
@end

