//
//  GTViewController.m
//  iOS Util
//
//  Created by Thierry on 13-7-24.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import "GTViewController.h"
#import "PaperView.h"

@implementation GTViewController

- (void)loadView
{
    [super loadView];
    
    PaperView *paperView = [[PaperView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:paperView];
}

@end
