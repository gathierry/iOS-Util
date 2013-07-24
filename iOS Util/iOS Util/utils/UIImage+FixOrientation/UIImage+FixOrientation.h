//
//  UIImage+FixOrientation.h
//  Colorwork
//
//  Created by lee on 12-11-29.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
@end
