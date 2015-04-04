//
//  PAImageProcessHelper.h
//  PAQZZ
//
//  Created by william mu on 13-10-9.
//  Copyright (c) 2013年 平安付. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+Extend.h"
//Image downsizing relevant
#define kPAMaxImageSizeMB 5.0f // The resulting image will be (x)MB of uncompressed image data.
#define kSourceImageTileSizeMB 5.0f // The tile size will be (x)MB of uncompressed image data.
#define bytesPerMB 1048576.0f
#define bytesPerPixel 4.0f
#define pixelsPerMB ( bytesPerMB / bytesPerPixel ) // 262144 pixels, for 4 bytes per pixel.
#define destSeemOverlap 2.0f // the numbers of pixels to overlap the seems where tiles meet.

#define kDefaultJPEGQuality 0.4

@interface PAImageProcessHelper : NSObject
+(UIImage*) compressImage:(UIImage*)img  withFrm:(CGSize) size;
//+(NSString*) saveAsJPEG:(UIImage*) img withQuality:(float) quality;
+(BOOL) saveThumbnailAtPath:(NSString*) path forImage:(UIImage*) image inSize:(CGSize) size;
+(CGSize) clampSizeTo:(CGSize) constraint size:(CGSize) rawSize;
+(UIImage *)adjustImageForAvatatUpload:(UIImage *)image size:(CGSize)size;
+(float) sizeInMBForImg:(UIImage*) img;
+(UIImage*) imageFromContext:(CGContextRef) context orientation:(UIImageOrientation) orientation;
//+(NSString*) saveAsJPEG:(UIImage *)img withQuality:(float)quality toPath:(NSString*) path;
@end
