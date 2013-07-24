//
//  AppDelegate.m
//  iOS Util
//
//  Created by Thierry on 13-7-24.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import "AppDelegate.h"
#import "GTViewController.h"

@implementation AppDelegate

@synthesize gtViewController = _gtViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.gtViewController = [[GTViewController alloc] init];
    self.window.rootViewController = self.gtViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
