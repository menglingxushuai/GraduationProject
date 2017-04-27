//
//  CALayer+XibBorderColor.m
//  WZ威赚4.0
//
//  Created by zwwl on 2017/3/30.
//  Copyright © 2017年 mlx_a. All rights reserved.
//

#import "CALayer+XibBorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (XibBorderColor)

- (void)setBorderUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}


@end
