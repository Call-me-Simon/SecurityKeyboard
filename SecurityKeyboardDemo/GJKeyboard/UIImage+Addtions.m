//
//  UIImage+Addtions.m
//  GJKeyBoard
//
//  Created by Yorke on 15/5/10.
//  Copyright (c) 2015年 wutongr. All rights reserved.
//

#import "UIImage+Addtions.h"
#import "UIColor+Addtions.h"

@implementation UIImage (Addtions)

+ (UIImage *)imageWithHexString:(NSString *)hex{
    UIColor *color = [UIColor colorWithHexString:hex alpha:1.0f];
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
