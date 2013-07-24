//
//  UIApplication+ActivitorCounter.m
//  Colorwork
//
//  Created by Thierry on 13-7-24.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import "UIApplication+NetworkActivityIndicator.h"

@implementation UIApplication (NetworkActivityIndicator)

static NSInteger networkActivityCount = 0;

- (NSInteger)networkActivityCount{
    @synchronized(self){
        return networkActivityCount;
    }
}

- (void)pushNetworkActivity{
    @synchronized(self){
        networkActivityCount ++;
    }
    [self refreshNetworkActivityIndicator];
}

- (void)popNetworkActivity{
    @synchronized(self){
        if (networkActivityCount > 0) {
            networkActivityCount--;
        }else{
            networkActivityCount = 0;
        }
    }
    
    [self refreshNetworkActivityIndicator];
}

- (void)refreshNetworkActivityIndicator{
    if (![NSThread isMainThread]) {
        SEL sel_refresh = @selector(refreshNetworkActivityIndicator);
        [self performSelectorOnMainThread:sel_refresh withObject:nil waitUntilDone:NO];
        return;
    }
    BOOL active = (self.networkActivityCount > 0);
    self.networkActivityIndicatorVisible = active;
}

- (void)resetNetworkActivity{
    @synchronized(self){
        networkActivityCount = 0;
    }
    [self refreshNetworkActivityIndicator];
}

@end
