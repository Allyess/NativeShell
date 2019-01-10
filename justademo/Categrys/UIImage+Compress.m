//
// Created by huamulou on 15/12/1.
// Copyright (c) 2015 alibaba. All rights reserved.
//

#import "UIImage+Compress.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Compress)
- (NSData *)dataByCompressToSize:(CGSize)size toQuality:(CGFloat)quality {
    UIImage *compressedImage = self;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (quality == 1) {
        return UIImagePNGRepresentation(compressedImage);
    } else {
        return UIImageJPEGRepresentation(compressedImage, quality);
    }
}

- (UIImage *)imageByCompressToSize:(CGSize)size toQuality:(CGFloat)quality {
    UIImage *compressedImage = self;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (quality == 1) {
        return compressedImage;
    } else {
        return [UIImage imageWithData:UIImageJPEGRepresentation(compressedImage, quality)];
    }
}

- (NSData *)dataByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality {
    return [self dataByCompressToSize:CGSizeMake(self.size.width * scale, self.size.height * scale) toQuality:quality];
}

- (UIImage *)imageByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality {
    return [self imageByCompressToSize:CGSizeMake(self.size.width * scale, self.size.height * scale) toQuality:quality];
}





@end
