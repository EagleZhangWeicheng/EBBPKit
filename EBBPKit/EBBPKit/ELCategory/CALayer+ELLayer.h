//
//  CALayer+LayerColor.h
//  EagleBasicLib
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CALayer (EBLLayer)
- (void)setBorderColorFromUIColor:(UIColor *)color;
@end
