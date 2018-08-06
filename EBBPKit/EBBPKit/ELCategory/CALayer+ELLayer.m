//
//  CALayer+LayerColor.m
//  EagleBasicLib
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CALayer+ELLayer.h"

@implementation CALayer (EBLLayer)
- (void)setBorderColorFromUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}
@end
