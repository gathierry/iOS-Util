//
//  Squiggle.h
//  Electronic Draft
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Squiggle : NSObject <NSCopying, NSCoding>
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) NSString *width;

- (void)addSomePoints:(CGPoint)point;

@end
