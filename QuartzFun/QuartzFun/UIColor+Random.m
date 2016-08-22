//
//  UIColor+Random.m
//  QuartzFun
//
//  Created by  Jierism on 16/8/1.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    CGFloat red = (CGFloat)(arc4random() % 256)/255;
    CGFloat blue = (CGFloat)(arc4random() % 256)/255;
    CGFloat green = (CGFloat)(arc4random() % 256)/255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
