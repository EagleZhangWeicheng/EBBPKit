//
//  ELLaunchConfig.h
//  EBBPKit
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ELLaunchSourceFrom) { //资源来源
    ELLaunchSourceLocal = 0, //本地资源
    ELLaunchSourceNet //网络资源
};

typedef NS_ENUM(NSInteger,ELLaunchConfigType) { //类型
    ELLaunchConfigTypeImages = 1, //图片
    ELLaunchConfigTypeVideos, //视频
    ELLaunchConfigTypeCustomViews //自定义view
};


@interface ELLaunchConfig : NSObject //图片视频启动或广告
@property(nonatomic)ELLaunchSourceFrom launchSourceFrom; //资源来源默认本地

@property(nonatomic,strong)UIColor * pageNomalColor; //page显示正常 默认
@property(nonatomic,strong)UIColor * pageSelColor; //page显示到选择颜色
@property(nonatomic,strong)UIColor * skipBnTextColor;     //跳过按钮颜色

@property(nonatomic,strong)NSArray *datas;//数据

@property(nonatomic)NSInteger showTime;//显示次数 //按照版本号和构建版本 0为一直显示
-(void)incShowTime;//显示一次增加一次数
@property(nonatomic)BOOL isCanShow; //是否显示

@end

@interface ELLaunchImagesConfig : ELLaunchConfig //图片启动配置 或者广告配置
@property(nonatomic,strong)UIImage *netPlaceholderImage;//网络请求占位图
@end

@interface ELLaunchVideosConfig : ELLaunchConfig //视频启动配置 或者广告配置

@end

@interface ELLaunchCustomViewConfig : ELLaunchConfig //自定view
@end

