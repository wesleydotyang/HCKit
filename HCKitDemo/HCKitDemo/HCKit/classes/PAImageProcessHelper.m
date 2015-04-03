//
//  PAImageProcessHelper.m
//  PAQZZ
//
//  Created by william mu on 13-10-9.
//  Copyright (c) 2013年 平安付. All rights reserved.
//

#import "PAImageProcessHelper.h"
#import "UIImage+Extend.h"
#import "HCKit.h"
@implementation PAImageProcessHelper


+(UIImage*) imageFromContext:(CGContextRef) context orientation:(UIImageOrientation) orientation
{
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    
    UIImage* image = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:orientation];
//    UIImage* image = [UIImage imageWithCGImage:cgImage];
    DebugAssert(image != nil, @"image is nil!");
    CGImageRelease(cgImage);
    
    return image;
}


+(float) sizeInMBForImg:(UIImage*) img
{
    CGSize size = img.size;
    
    float dimention = size.width * size.height;
    float sizeInMB = ( dimention * bytesPerPixel ) / (1024 * 1024);
    
    return sizeInMB;
}

+(UIImage*) compressImage:(UIImage*)img  withFrm:(CGSize) size
{
    return img;
}


+(NSString*) saveAsJPEG:(UIImage *)img withQuality:(float)quality toPath:(NSString*) path
{
    NSData* data = UIImageJPEGRepresentation(img, quality);
    
    BOOL b = [data writeToFile:path atomically:YES];
    
    if(!b)
    {
//        DDLogError(@"write to file:%@ failed!", path);
        return nil;
    }
    
    return path;
}

//+(NSString*) saveAsJPEG:(UIImage*) img withQuality:(float) quality
//{
//    NSString* path = self.uniqueTmpPath;
//    return [self saveAsJPEG:img withQuality:quality toPath:path];
//}

+(BOOL) saveThumbnailAtPath:(NSString*) path forImage:(UIImage*) image inSize:(CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* data = UIImageJPEGRepresentation(thumbImg, kDefaultJPEGQuality);
    
    BOOL b = [data writeToFile:path atomically:YES];
    return b;
}

+(CGSize) clampSizeTo:(CGSize) constraint size:(CGSize) rawSize
{
    if(rawSize.width <= constraint.width && rawSize.height <= constraint.height)
        return rawSize;
    
    CGFloat k1 = constraint.width / rawSize.width;
    CGFloat k2 = constraint.height / rawSize.height;
    
    CGFloat k = MIN(k1, k2);
    
    CGSize ret = rawSize;
    ret.width *= k;
    ret.height *= k;
    
    return ret;
}
+(UIImage *)adjustImageForAvatatUpload:(UIImage *)image size:(CGSize)size{
    //imageViewPacker选取图片，不进行缩放时会取到原图，此时不为正方形
    if (image.size.width !=image.size.height) {
        float width = image.size.width;
        float height = image.size.height;
        float small = MIN(width, height);
        float subWidth = width - small;
        float subHeight = height - small;
        
        CGRect rect = CGRectMake(subWidth/2, subHeight/2, small, small);
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
        CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
        
        UIGraphicsBeginImageContext(smallBounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, smallBounds, subImageRef);
        image = [UIImage imageWithCGImage:subImageRef];
        
        CGImageRelease(subImageRef);
        UIGraphicsEndImageContext();
    }
    return [image scaleToSize:size];
    
}
@end
