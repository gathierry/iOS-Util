//
//  Squiggle.m
//  Electronic Draft
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define SQUIGGLE_COLOR @"blue"
#define SQUIGGLE_WIDTH @"5.0"

#import "Squiggle.h"

@implementation Squiggle
@synthesize pointsArray = _pointsArray;
@synthesize strokeColor = _strokeColor;

@synthesize width = _width;

- (NSMutableArray *)pointsArray
{
    if (!_pointsArray) {
        _pointsArray = [[NSMutableArray alloc] init];
    }
    return _pointsArray;
}

- (UIColor *)strokeColor
{
    if (!_strokeColor) {
        _strokeColor = [UIColor blueColor];
    }
    return _strokeColor;
}

- (NSString *)width
{
    if (!_width) _width = SQUIGGLE_WIDTH;
    return _width;
}

- (void)addSomePoints:(CGPoint)point
{
    [self.pointsArray addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:point.x], [NSNumber numberWithFloat:point.y], nil]];//[NSValue valueWithCGPoint:point]];
}

- (id)copyWithZone:(NSZone *)zone
{
    Squiggle *newSquiggle = [[Squiggle allocWithZone:zone] init];
    newSquiggle.pointsArray = self.pointsArray;
    newSquiggle.strokeColor = self.strokeColor;
    newSquiggle.width = self.width;
    return newSquiggle;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_pointsArray forKey:@"pointsArray"];
    [aCoder encodeObject:_strokeColor forKey:@"strokeColor"];
    [aCoder encodeObject:_width forKey:@"width"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.pointsArray = [aDecoder decodeObjectForKey:@"pointsArray"];
        self.strokeColor = [aDecoder decodeObjectForKey:@"strokeColor"];
        self.width = [aDecoder decodeObjectForKey:@"width"];
    }
    return self;
}

@end
