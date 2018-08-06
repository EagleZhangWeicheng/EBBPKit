//
//  TabViewController.m
//  EBBPKit
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import "TabViewController.h"
#import "ELLaunchView.h"
#import "EBBPKit.h"
@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ELLaunchView *launchView = [[ELLaunchView alloc] initLocalImageStrs:@[@"image1",@"image2",@"image3"]];
//    [self.view addSubview:launchView];
//    [ELLaunchView showLocalImageStrs:@[@"image1",@"image2",@"image3"]];
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"appversion %@",app_Version);
    NSLog(@"EL_screen_width %f",EL_screen_width);
    NSLog(@"EL_screen_height %f",EL_screen_height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
