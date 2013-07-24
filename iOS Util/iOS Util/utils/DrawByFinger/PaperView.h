//
//  PaperView.h
//  Electronic Draft
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Squiggle.h"
@class PaperView;
@protocol PaperViewDataSource <NSObject>

- (void)paperViewDelegate:(PaperView *)sender;

@end

@interface PaperView : UIView
@property (nonatomic, strong) Squiggle *squiggle;
@property (nonatomic, strong) NSMutableArray *paint;
@property (nonatomic, strong) NSString *infoType;
//@property BOOL forUndo;
@property (weak, nonatomic) id<PaperViewDataSource> dataSource;

- (void)handleThreeTap;


@end
