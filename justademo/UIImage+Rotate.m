//
//  UIImage+Rotate.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "UIImage+Rotate.h"

@implementation UIImage (Rotate)

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {

    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);

    CGSize rotatedSize;

    rotatedSize.width = width;
    rotatedSize.height = height;

    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width / 2, -rotatedSize.height / 2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



- (UIImage *)imageRotatedByRight_angle
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = height;
    rotatedSize.height = width;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(bitmap, M_PI/2);
    CGContextTranslateCTM(bitmap, 0, -height);
    CGContextScaleCTM(bitmap, 1, -1.0);
    CGContextTranslateCTM(bitmap, 0, -height);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
