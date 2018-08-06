//
//  ELLaunchDownload.m
//  EBBPKit
//
//  Created by Mac on 2018/7/31.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "ELLaunchDownload.h"
#import <AFNetworking/AFNetworking.h>
@implementation ELLaunchDownload
-(void)downloadUrl:(NSString*)urlStr;{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *downloadTask =
    [manager downloadTaskWithRequest:request
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                         
                                    }
                         destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                             NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                             return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                    }
                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                       NSLog(@"finsh error %@",error);
                       NSLog(@"filePath %@",filePath);
//                       NSLog(@"response %@",response);
//                       if (self.downloadFinishBlock) {
//                           self.downloadFinishBlock(self);
//                       }
                   }];
    [downloadTask resume];
}


+(void)downloadUrls:(NSArray*)urlStrs downloadFinishBlock:(ELLaunchDownloadFinishBlock)downloadFinishBlock;{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSInteger index = 0;
    for (NSString *urlStr in urlStrs) {
        if (![ELLaunchDownload isExvideoPathByUrlStr:urlStr]) {
            NSURL *url = [NSURL URLWithString:urlStr];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            ELLaunchDownload *dowLoad = [[ELLaunchDownload alloc] init];
            dowLoad.tag = index;
            [dowLoad managerDownload:manager request:request urlStr:urlStr];
            dowLoad.downloadFinishBlock = downloadFinishBlock;
        }
        index ++;
    }
}

-(void)managerDownload:(AFURLSessionManager *)manager request:(NSURLRequest*)request urlStr:(NSString*)urlStr{
    NSURLSessionDownloadTask *downloadTask =
    [manager downloadTaskWithRequest:request
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                
                            }
                         destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                             NSURL *url =  [NSURL fileURLWithPath:[ELLaunchDownload downVideoPath]];
                             NSArray *ar = [[response suggestedFilename] componentsSeparatedByString:@"."];
                             if (ar.count > 1) {
                                 return [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[ELLaunchDownload md5String:urlStr],[ar objectAtIndex:1]]];
                             }
                             else{
                                 return [url URLByAppendingPathComponent:[response suggestedFilename]];
                             }
                         }
                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                       if (self.downloadFinishBlock) {
                           self.downloadFinishBlock(self);
                       }
                   }];
    [downloadTask resume];

}


+(NSString*)downVideoPath{ //文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:ELLaunchDownloadVideoKey];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+(BOOL)isExvideoPathByUrlStr:(NSString*)urlStr;{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[ELLaunchDownload videoPathByUrlStr:urlStr]]) {
        return true;
    }
    return false;
}

+(NSString*)videoPathByUrlStr:(NSString*)urlStr;{ //视频路径
    NSString *path = [ELLaunchDownload downVideoPath];
    NSArray *ar = [urlStr componentsSeparatedByString:@"."];
    if (ar.count > 0) {
        NSString *subfix = ar.lastObject;
       path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[ELLaunchDownload md5String:urlStr],subfix]];
    }
    else{
       path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[ELLaunchDownload md5String:urlStr]]];
    }
    return  path;
    
}

+(NSString *)md5String:(NSString *)string{
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}


@end
