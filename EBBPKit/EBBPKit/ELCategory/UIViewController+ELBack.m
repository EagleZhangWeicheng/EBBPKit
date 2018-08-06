//
//  UIViewController+ELBack.m
//  EBBPKit
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Eagle. All rights reserved.
//

#import "UIViewController+ELBack.h"
#import <objc/runtime.h>
@implementation UIViewController (ELBack)

-(void)setIsSetBack:(BOOL)isSetBack{
    if (isSetBack != self.isSetBack) {
        objc_setAssociatedObject(self, @"isSetBack", [NSNumber numberWithBool:isSetBack], OBJC_ASSOCIATION_ASSIGN);
    }
    
    if (isSetBack) {
        [self elAddBackBn];
    }
}

-(BOOL)isSetBack{
    return objc_getAssociatedObject(self, @"isSetBack");
}

-(void)elAddBackBn{
    UIButton *backBn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBn.frame = CGRectMake(0, 0, 50, 44);
    [backBn addTarget:self action:@selector(elBackPress:) forControlEvents:UIControlEventTouchUpInside];
    if ([ELConfig shareConfig].backConfig.backImageName) {
        UIImage *image = [UIImage imageNamed:[ELConfig shareConfig].backConfig.backImageName];
        [backBn setImage:image forState:UIControlStateNormal];
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBn];
    self.navigationItem.leftBarButtonItem = leftItem;
}


-(void)elBackPress:(id)sender{
    if ([self isEqual:self.navigationController.topViewController]) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
