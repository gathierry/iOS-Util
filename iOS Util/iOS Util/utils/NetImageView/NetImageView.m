//
//  NetImageView.m
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-31.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import "NetImageView.h"
#import "NetImageEngine.h"

@interface NetImageView ()
{
    NSString * _imageUrl;
    UIActivityIndicatorView * _indicatorView;
}

@end

@implementation NetImageView

@synthesize placeholderImage = _placeholderImage;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationReceivied:)
                                                     name:NOTIFICATION_IMAGE_LOADED
                                                   object:nil];
    }
    return self;
}

- (void)startLoadImage:(NSString *)url
{
    _imageUrl = [[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] copy];
    [self setImage:self.placeholderImage];
    [self reloadData];
}

- (void)notificationReceivied:(NSNotification *)notification
{
    NSString * url = notification.object;
    if (![StringUtils isEmpty:_imageUrl] && [_imageUrl isEqualToString:url]) {
        [self reloadData];
    }
}

- (void)reloadData
{
    if ([StringUtils isEmpty:_imageUrl]) {
        self.image = self.placeholderImage;
        return;
    }
    
    self.image = [[NetImageEngine sharedEngine] getImageByUrl:_imageUrl] ? [[NetImageEngine sharedEngine] getImageByUrl:_imageUrl] : self.placeholderImage;
}

- (void)layoutSubviews
{
    _indicatorView.frame = CGRectMake((self.frame.size.width - _indicatorView.frame.size.width) / 2.0,
                                      (self.frame.size.height - _indicatorView.frame.size.height) / 2.0,
                                      _indicatorView.frame.size.width,
                                      _indicatorView.frame.size.height);
}

@end
