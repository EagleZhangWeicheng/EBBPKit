//
//  ELLaunchManager.m
//  EBBPKit
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import "ELLaunchManager.h"
#import "ELLaunchView.h"
#import "ELLaunchDownload.h"
#define videoURL1 @"http://yun.it7090.com/video/XHLaunchAd/video01.mp4"
#define videoURL2 @"http://yun.it7090.com/video/XHLaunchAd/video02.mp4"
#define videoURL3 @"http://yun.it7090.com/video/XHLaunchAd/video03.mp4"

static ELLaunchManager *launchManager = nil;

@implementation ELLaunchManager
+(void)load{
    [ELLaunchManager shareManager];
}

+(instancetype)shareManager;{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchManager = [[ELLaunchManager alloc] init];
    });
    return launchManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            NSInteger tag = random()%3;
            NSLog(@"test %ld",tag);
            tag = 3;
            [self setLaunchWithTag:tag];
        }];
    }
    return self;
}

-(void)setLaunchWithTag:(NSInteger)tag{
    if (tag == 0) {
        [self launchLocalImages];
    }
    else if(tag == 1){
        [self launchNetImages];
    }
    else if(tag == 2){
        [self launchLocalCustomViews];
    }
    else if (tag == 3){
        [self launchVideos];
    }
    
//    ELLaunchDownload *download = [[ELLaunchDownload alloc] init];
//    [ELLaunchDownload downloadUrls:@[videoURL1,videoURL2,videoURL3] downloadFinishBlock:nil];
}

-(void)launchLocalImages{
    ELLaunchImagesConfig *config = [[ELLaunchImagesConfig alloc] init];
    config.showTime = 1;
    config.datas = @[@"image1",@"image2",@"image3"];
    [ELLaunchView launchImagesWithConfig:config delegate:self];
}

-(void)launchNetImages{
    ELLaunchImagesConfig *config = [[ELLaunchImagesConfig alloc] init];
    config.launchSourceFrom = ELLaunchSourceNet;
    config.datas = @[@"http://yun.it7090.com/image/XHLaunchAd/pic01.jpg",
                     @"http://yun.it7090.com/image/XHLaunchAd/pic02.jpg",
                     @"http://yun.it7090.com/image/XHLaunchAd/pic03.jpg",
                     @"http://yun.it7090.com/image/XHLaunchAd/pic04.jpg"];
    [ELLaunchView launchImagesWithConfig:config delegate:self];
}


-(void)launchLocalCustomViews{
    ELLaunchCustomViewConfig *config = [[ELLaunchCustomViewConfig alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor redColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view1.backgroundColor = [UIColor grayColor];

    UIView *view2= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view2.backgroundColor = [UIColor blueColor];
    
    UIView *view3 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view3.backgroundColor = [UIColor greenColor];
    
    config.datas = @[view,view1,view2,view3];

    [ELLaunchView launchCustomViewsWithConfig:config delegate:self];
}

-(void)launchVideos{
    ELLaunchVideosConfig *config = [[ELLaunchVideosConfig alloc] init];
    config.launchSourceFrom = ELLaunchSourceNet;
    config.datas = @[videoURL1,videoURL2,videoURL3];
    [ELLaunchView launchVideosWithConfig:config delegate:self];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
}

@end
