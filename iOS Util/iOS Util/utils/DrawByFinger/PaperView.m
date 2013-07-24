//
//  PaperView.m
//  Electronic Draft
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PaperView.h"
#import "Squiggle.h"
//#import "tcpSocketChat.h"

@interface PaperView()

@end

@implementation PaperView
@synthesize squiggle = _squiggle;
@synthesize paint = _paint;
@synthesize dataSource = _dataSource;
@synthesize infoType = _infoType;

- (void)handleThreeTap
{
    [self.paint removeAllObjects];
    self.infoType = @"clear";
    [self.dataSource paperViewDelegate:self];
    [self setNeedsDisplay];
}

- (void)setInfoType:(NSString *)infoType
{
    if (![_infoType isEqualToString:infoType]) _infoType = infoType;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *threeTapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleThreeTap)];
        threeTapGestureRec.numberOfTapsRequired = 3;
        [self addGestureRecognizer:threeTapGestureRec];
    }
    return self;
}

- (Squiggle *)squiggle
{
    if (!_squiggle) _squiggle = [[Squiggle alloc] init];
    return _squiggle;
}

- (NSMutableArray *)paint
{
    if (!_paint)  _paint = [[NSMutableArray alloc] init];
    return _paint;
}

- (BOOL)isMultipleTouchEnabled
{
    return YES;
}

- (CGPoint)midPointPointOne:(CGPoint)pt1 pointTwo:(CGPoint)pt2
{
    CGPoint pt;
    pt.x = (pt1.x + pt2.x) * 0.5;
    pt.y = (pt1.y + pt2.y) * 0.5;
    return pt;
}

- (CGFloat)zoomInView:(CGFloat)f XY:(NSString *)cor
{
    if ([cor isEqualToString:@"x"]) {
        return f / SCREEN_WIDTH * self.frame.size.width;
    }
    else {
        return f / SCREEN_HEIGHT * self.frame.size.height;
    }
    
}

- (void)drawASquiggleDejaVu:(Squiggle *)aSquiggle
                  inContext:(CGContextRef)context
{
    if (!aSquiggle.pointsArray.count)  return;
    
    CGContextSetLineWidth(context, [aSquiggle.width floatValue]);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES); //抗锯齿，用不用再说。
    CGContextSetFlatness(context, 0.1f);
    [aSquiggle.strokeColor setStroke];
    CGPoint pt0, pt1, pt2;
    NSMutableArray *array = [aSquiggle.pointsArray mutableCopy];
    if (aSquiggle.pointsArray.count == 1) {
        pt0.x = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:0] floatValue] XY:@"x"];
        pt0.y = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:1] floatValue] XY:@"y"];
        CGContextMoveToPoint(context, pt0.x, pt0.y);
        CGContextAddLineToPoint(context, pt0.x, pt0.y);
        CGContextStrokePath(context);
    }
    else if (aSquiggle.pointsArray.count == 2) {
        pt0.x = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:0] floatValue] XY:@"x"];
        pt0.y = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:1] floatValue] XY:@"y"];
        pt1.x = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:0] floatValue] XY:@"x"];
        pt1.y = [self zoomInView:[[[array objectAtIndex:0] objectAtIndex:1] floatValue] XY:@"y"];
        CGContextMoveToPoint(context, pt0.x, pt0.y);
        CGContextAddLineToPoint(context, pt1.x, pt1.y);
        CGContextStrokePath(context);
    }
    else {
        for (int i = 0; i < (array.count - 2); i ++) {
            pt0.x = [self zoomInView:[[[array objectAtIndex:i] objectAtIndex:0] floatValue] XY:@"x"];
            pt0.y = [self zoomInView:[[[array objectAtIndex:i] objectAtIndex:1] floatValue] XY:@"y"];
            pt1.x = [self zoomInView:[[[array objectAtIndex:i+1] objectAtIndex:0] floatValue] XY:@"x"];
            pt1.y = [self zoomInView:[[[array objectAtIndex:i+1] objectAtIndex:1] floatValue] XY:@"y"];
            pt2.x = [self zoomInView:[[[array objectAtIndex:i+2] objectAtIndex:0] floatValue] XY:@"x"];
            pt2.y = [self zoomInView:[[[array objectAtIndex:i+2] objectAtIndex:1] floatValue] XY:@"y"];
            CGPoint mid1 = [self midPointPointOne:pt0 pointTwo:pt1];
            CGPoint mid2 = [self midPointPointOne:pt1 pointTwo:pt2];
            CGContextMoveToPoint(context, mid1.x, mid1.y);
            CGContextAddQuadCurveToPoint(context, pt1.x, pt1.y, mid2.x, mid2.y);
            CGContextStrokePath(context);
            
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //_forUndo =NO;
    self.squiggle.pointsArray = [NSMutableArray array];
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self.squiggle addSomePoints:pt];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self.squiggle addSomePoints:pt];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    Squiggle *squiggle;
    squiggle = [self.squiggle copy];
    [self.paint addObject:squiggle];
    self.infoType = @"draw";
    [self.dataSource paperViewDelegate:self];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.paint.count) {
        for (int j = 0; self.paint.count > j; j ++) {
            if ([[self.paint objectAtIndex:j] isKindOfClass:[Squiggle class]]) {
                Squiggle *squiggle = [self.paint objectAtIndex:j];
                [self drawASquiggleDejaVu:squiggle inContext:context];
            }
        }
    }
    //if (!_forUndo) [self drawASquiggleDejaVu:self.squiggle inContext:context];
    [self drawASquiggleDejaVu:self.squiggle inContext:context];
}


@end
