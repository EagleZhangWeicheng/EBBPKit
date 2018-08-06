//
//  ELIntroductionView.m
//  EBBPKit
//
//  Created by Eagle on 2018/7/30.
//  Copyright © 2018年 Eagle. All rights reserved.
//


#import "ELLaunchView.h"
#import "UIImageView+WebCache.h"
#import "ELLaunchDownload.h"
@implementation ELLaunchViewCell

-(void)setLaunchConfigType:(ELLaunchConfigType)launchConfigType{
    if (_launchConfigType != launchConfigType) {
        _launchConfigType = launchConfigType;
        if (_launchConfigType == ELLaunchConfigTypeImages) {
            [self initSetImages];
        }
        else if (_launchConfigType == ELLaunchConfigTypeVideos) {
            [self initSetVideos];
        }
    }
}

-(void)initSetImages{
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
}

-(void)initSetVideos{
    if (!self.launchVideoView) {
        self.launchVideoView = [[ELLaunchVideoView alloc] initWithFrame:self.bounds];
        [self addSubview:self.launchVideoView];
    }
}

@end


static ELLaunchView *launchView = nil;
@interface ELLaunchView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *contentCollectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)ELLaunchSkipButton* skipBn;     //跳过按钮

@property(nonatomic,strong) ELLaunchConfig *config;//配置文件
@property(nonatomic)ELLaunchConfigType launchConfigType; //配置类型
@property(nonatomic,assign,nullable) id <ELLaunchDelgate> delegate;

+(instancetype)shareManager;
@end
@implementation ELLaunchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSet];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSet];
    }
    return self;
}


+(instancetype)shareManager;{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchView = [[ELLaunchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return launchView;
}

+(void)launchImagesWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate;{ //图片
    [[ELLaunchView shareManager] setWithConfig:config delegate:delegate];
}

+(void)launchVideosWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate;{ //视频
    [[ELLaunchView shareManager] setWithConfig:config delegate:delegate];
}

+(void)launchCustomViewsWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delegate; {//自定义view
    [[ELLaunchView shareManager] setWithConfig:config delegate:delegate];
}

-(void)setWithConfig:(ELLaunchConfig*)config delegate:(nullable id)delgate{
    if (!config.isCanShow) {
        return;
    }
    
    if ([config isKindOfClass:[ELLaunchImagesConfig class]]) {
        self.launchConfigType = ELLaunchConfigTypeImages;
    }
    else if ([config isKindOfClass:[ELLaunchVideosConfig class]]) {
        self.launchConfigType = ELLaunchConfigTypeVideos;
        [ELLaunchDownload downloadUrls:config.datas downloadFinishBlock:^(ELLaunchDownload *download) {
            NSLog(@"downloadUrls finish");
            [self.contentCollectionView reloadData];
        }];
    }
    else if ([config isKindOfClass:[ELLaunchCustomViewConfig class]]) {
        self.launchConfigType = ELLaunchConfigTypeCustomViews;
    }
    else{
        return;
    }
    self.config = config;
    self.delegate = delgate;
    [self initSetWithConfig];
    [self.contentCollectionView reloadData];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}


-(void)initSet{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.pagingEnabled = true;
    self.contentCollectionView.showsVerticalScrollIndicator = false;
    self.contentCollectionView.showsHorizontalScrollIndicator = false;
    self.contentCollectionView.bounces = false;
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentCollectionView registerClass:[ELLaunchViewCell class] forCellWithReuseIdentifier:@"ELLaunchViewCell"];
    [self addSubview:self.contentCollectionView];
}

-(void)initSetWithConfig{
    CGSize viewSize = self.frame.size;
    if (self.config.datas.count > 1) {
        CGFloat pageControlH = 50;
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, viewSize.height - pageControlH, viewSize.width, pageControlH)];
        self.pageControl.numberOfPages = self.config.datas.count;
        self.pageControl.pageIndicatorTintColor = self.config.pageNomalColor == nil?[UIColor grayColor]:self.config.pageNomalColor;
        self.pageControl.currentPageIndicatorTintColor = self.config.pageSelColor == nil?[UIColor blackColor]:self.config.pageSelColor;
        [self addSubview:self.pageControl];
    }
    
    
    CGSize skipBnSize = CGSizeMake(50, 50);
    self.skipBn = [ELLaunchSkipButton buttonWithType:UIButtonTypeCustom];
    [self.skipBn setTitle:@"跳过" forState:UIControlStateNormal];
    UIColor *skColor = self.config.skipBnTextColor == nil?[UIColor whiteColor]:self.config.skipBnTextColor ;
    [self.skipBn setTitleColor:skColor forState:UIControlStateNormal];
    [self.skipBn addTarget:self action:@selector(skipPress:) forControlEvents:UIControlEventTouchUpInside];
    self.skipBn.frame = CGRectMake(viewSize.width - skipBnSize.width - 20,viewSize.height - skipBnSize.height, skipBnSize.width, skipBnSize.height);
    [self addSubview:self.skipBn];
}


-(void)skipPress:(id)sender{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                          } completion:^(BOOL finished) {
                              [self launchViewDidFinish];
                          }];
}

#pragma mark 完成动作
-(void)launchViewDidFinish{
    [self removeFromSuperview];
    if (self.config.showTime != 0) {
        [self.config incShowTime];
    }
    
    if (self.launchViewDidFinishBlock) {
        self.launchViewDidFinishBlock(self);
    }
    
    if ([self.delegate respondsToSelector:@selector(launchViewDidFinish:)]) {
        [self.delegate launchViewDidFinish:self];
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return self.config.datas.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ELLaunchViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ELLaunchViewCell" forIndexPath:indexPath];
    cell.launchConfigType = self.launchConfigType;

    if (self.launchConfigType == ELLaunchConfigTypeImages) {
        if(self.config.datas.count  > 0){
            [self addImageToCell:cell id:[self.config.datas objectAtIndex:indexPath.row]];
        }
    }
    else if (self.launchConfigType == ELLaunchConfigTypeVideos){
        [self addVideoToCell:cell id:[self.config.datas objectAtIndex:indexPath.row] row:indexPath.row];
    }
    else if (self.launchConfigType == ELLaunchConfigTypeCustomViews){
        if (self.config.datas.count > 0) {
            [self addCustomViewToCell:cell id:[self.config.datas objectAtIndex:indexPath.row]];
        }
    }
    return cell;
}

-(void)addImageToCell:(ELLaunchViewCell*)cell id:(id)data{
    if ([data isKindOfClass:[NSString class]]) {
      NSString*  imageName = (NSString*)data;
        if (self.config.launchSourceFrom == ELLaunchSourceNet) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:((ELLaunchImagesConfig*)self.config).netPlaceholderImage];
        }
        else{
            cell.imageView.image = [UIImage imageNamed:imageName];
        }
    }
}

-(void)addVideoToCell:(ELLaunchViewCell*)cell id:(id)data row:(NSInteger)row{
    NSString*  videoName = (NSString*)data;
    if ([data isKindOfClass:[NSString class]]) {
        if (self.config.launchSourceFrom == ELLaunchSourceNet) {
            NSString *path = [ELLaunchDownload videoPathByUrlStr:videoName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                if (!cell.launchVideoView.contentURL) {
                    cell.launchVideoView.contentURL = [NSURL fileURLWithPath:path];
                    if (row == 0) {
                        [cell.launchVideoView.videoPlayer.player play];
                    }
                }
            }
        }
        else{
            NSString *path = data;
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                if (!cell.launchVideoView.contentURL) {
                    cell.launchVideoView.contentURL = [NSURL fileURLWithPath:path];
                    if (row == 0) {
                        [cell.launchVideoView.videoPlayer.player play];
                    }
                }
            }
        }
    }
}

-(void)playByRow:(NSInteger)row{
    for (NSInteger index = 0; index<self.config.datas.count; index++) {
        ELLaunchViewCell *cell = (ELLaunchViewCell*)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (cell) {
            if (index == row) {
                [cell.launchVideoView.videoPlayer.player play];
            }
            else{
                [cell.launchVideoView.videoPlayer.player pause];
                [cell.launchVideoView.videoPlayer.player seekToTime:kCMTimeZero];
            }
        }
    }
}

-(void)playFirst{
    BOOL isFirst = true;
    for (NSInteger index = 0; index<self.config.datas.count; index++) {
        ELLaunchViewCell *cell = (ELLaunchViewCell*)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (cell) {
            CMTime time = [cell.launchVideoView.videoPlayer.player currentTime];
            if (isnan(CMTimeGetSeconds(time))) {
                isFirst = false;
            }
        }
    }
    
    if (isFirst) {
        [self playByRow:0];
    }
}


-(void)addCustomViewToCell:(ELLaunchViewCell*)cell id:(id)data{
    if ([data isKindOfClass:[UIView class]]) {
        [cell addSubview:(UIView *)data];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    return self.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;{
    return 0;
}

#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(selectSection:launchView:)]) {
        [self.delegate selectSection:indexPath.row launchView:self];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    self.pageControl.currentPage = index;
    if (self.launchConfigType == ELLaunchConfigTypeVideos) {
        [self playByRow:index];
    }
}



@end
