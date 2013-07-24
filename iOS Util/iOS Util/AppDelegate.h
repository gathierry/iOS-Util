//
//  AppDelegate.h
//  iOS Util
//
//  Created by Thierry on 13-7-24.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) GTViewController *gtViewController;

@end
