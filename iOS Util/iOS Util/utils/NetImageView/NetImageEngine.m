//
//  NetImageEngine.m
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-31.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import "NetImageEngine.h"

@interface NetImageEngine ()

{
    NSMutableDictionary * _images;
    NSMutableArray * _imageUrls;
    BOOL _loading;
}

@end


@implementation NetImageEngine

- (id)init
{
    self = [super init];
    if (self) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePathOfImages]]) {
            _images = [[NSMutableDictionary alloc] initWithContentsOfFile:[self filePathOfImages]];
        }
        else {
            _images = [[NSMutableDictionary alloc] init];
        }
        
        _imageUrls = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (NetImageEngine *)sharedEngine
{
    static NetImageEngine *sharedEngine = nil;
    if (sharedEngine == nil) {
        sharedEngine = [[NetImageEngine alloc] init];
    }
    
    return sharedEngine;
}

- (NSData *)downloadImageUrl:(NSString *)imageUrl
{
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [theRequest setHTTPMethod:@"GET"];
    //[theRequest setValue:HEAD_REFERER forHTTPHeaderField:@"Referer"];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest
                                         returningResponse:&response error:&error];
    return data;
}

- (void)getImageData:(NSString *)imageUrl
{
    [_imageUrls removeObjectAtIndex:0];
    
    NSString *imageType = @".png";
    NSRange range = [imageUrl rangeOfString:@"." options:NSBackwardsSearch];
    if (range.length) {
        imageType = [imageUrl substringFromIndex:range.location];
    }
    
    NSData *data = [self downloadImageUrl:imageUrl];
    NSString * saveImageName = [NSString stringWithFormat:@"%.0lf%d%@", [[NSDate date] timeIntervalSince1970], rand() % 999, imageType];
    [data writeToFile:[self filePathOfImage:saveImageName] atomically:YES];
    
    [_images setObject:saveImageName forKey:imageUrl];
    [_images writeToFile:[self filePathOfImages] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_IMAGE_LOADED object:imageUrl];
    
    _loading = NO;
    [self startLoad];
}

- (void)startLoad
{
    if ([_imageUrls count] == 0) return;
    if (_loading) return;
    _loading = YES;
    dispatch_queue_t downloadImageQueue = dispatch_queue_create("get image data", NULL);
    dispatch_async(downloadImageQueue, ^{
        [self getImageData:[_imageUrls objectAtIndex:0]];
    });
}

- (UIImage *)getImageByUrl:(NSString *)url
{
    if ([StringUtils isEmpty:url]) return nil;
    NSString * fileName = [_images objectForKey:url];
    UIImage *fileImage = [UIImage imageWithContentsOfFile:[self filePathOfImage:fileName]];
    if (fileImage)  return fileImage;
    
    [_imageUrls addObject:url];
    [self startLoad];
    return nil;
}

- (NSString *)filePathOfImages
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * docDirectory = [paths objectAtIndex:0];
    return [docDirectory stringByAppendingPathComponent:@"images.plist"];
}

- (NSString *)filePathOfImage:(NSString *)fileName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * docDirectory = [paths objectAtIndex:0];
    NSString * imageDir = [docDirectory stringByAppendingPathComponent:@"images"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDir
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return [imageDir stringByAppendingPathComponent:fileName];
}

@end
