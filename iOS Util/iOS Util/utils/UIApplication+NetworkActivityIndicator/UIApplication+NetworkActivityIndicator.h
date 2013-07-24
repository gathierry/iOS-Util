//
//  UIApplication+ActivitorCounter.h
//  Colorwork
//
//  Created by Thierry on 13-7-24.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (NetworkActivityIndicator)

@property (nonatomic, assign, readonly) NSInteger networkActivityCount;

- (void)pushNetworkActivity;
- (void)popNetworkActivity;
- (void)resetNetworkActivity;

@end
