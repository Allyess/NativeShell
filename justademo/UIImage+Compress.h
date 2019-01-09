//
// Created by huamulou on 15/12/1.
// Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Compress)
/**
 * @description 按分辨率和质量压缩图片
 * @param size 压缩到的分辨率
 * @param quality 压缩到的质量
 * @return image data
 */
- (NSData *)dataByCompressToSize:(CGSize)size toQuality:(CGFloat)quality;

/**
 * @description 按分辨率和质量压缩图片
 * @param size 压缩到的分辨率
 * @param quality 压缩到的质量
 * @return image
 */
- (UIImage *)imageByCompressToSize:(CGSize)size toQuality:(CGFloat)quality;

/**
 * @description 按分辨率比例和质量压缩图片
 * @param scale 压缩到的分辨率比例
 * @param quality 压缩到的质量
 */
- (NSData *)dataByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality;

/**
 * @description 按分辨率比例和质量压缩图片
 * @param scale 压缩到的分辨率比例
 * @param quality 压缩到的质量
 */
- (UIImage *)imageByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality;


@end
