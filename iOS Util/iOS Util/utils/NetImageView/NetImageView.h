//
//  NetImageView.h
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-31.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetImageView : UIImageView

@property (nonatomic, strong) UIImage *placeholderImage;

- (void)startLoadImage:(NSString *)url;

@end
