//
//  ELLaunchVideoView.h
//  EBBPKit
//
// 视频view 暂时全部下载到本地再播放 以后需扩展到一遍播放一遍下载
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface ELLaunchVideoView : UIView
@property (nonatomic, strong) AVPlayerViewController *videoPlayer;
@property (nonatomic, assign) MPMovieScalingMode videoScalingMode;
@property (nonatomic, assign) AVLayerVideoGravity videoGravity;
@property (nonatomic, assign) BOOL videoCycleOnce;
@property (nonatomic, assign) BOOL muted;
@property (nonatomic, strong) NSURL *contentURL;

-(void)stopVideoPlayer;

@end
