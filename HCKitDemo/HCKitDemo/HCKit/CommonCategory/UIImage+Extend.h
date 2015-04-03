#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage (UIImageExtension)

- (UIImage *)stretchableImage;
-(UIImage*)scaleToSize:(CGSize)size;

@end
