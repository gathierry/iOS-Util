//
//  NetImageEngine.h
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-31.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StringUtils.h"

#define NOTIFICATION_IMAGE_LOADED @"notification_image_loaded"

@interface NetImageEngine : NSObject

+ (NetImageEngine *)sharedEngine;

- (UIImage *)getImageByUrl:(NSString *)url;

@end
