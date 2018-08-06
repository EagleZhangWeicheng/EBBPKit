//
//  ELLaunchDownload.h
//  EBBPKit
//
//  基于AFNetworking的下载器
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#define ELLaunchDownloadVideoKey @"ELLaunchDownloadVideo"

#import <Foundation/Foundation.h>
@class ELLaunchDownload;
typedef void (^ELLaunchDownloadFinishBlock) (ELLaunchDownload *download);

@interface ELLaunchDownload : NSObject

-(void)downloadUrl:(NSString*)urlStr;
+(void)downloadUrls:(NSArray*)urlStrs downloadFinishBlock:(ELLaunchDownloadFinishBlock)downloadFinishBlock;

@property(nonatomic)NSInteger tag;
+(NSString*)videoPathByUrlStr:(NSString*)urlStr; //视频路径
@property(nonatomic,copy)ELLaunchDownloadFinishBlock downloadFinishBlock;
@end
