//
//  BackgroundView.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 12/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame {
    
    CGRect frameSize = CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height);
    
    self = [super initWithFrame:frameSize];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    [self drawBackground:rect inContext:context withColorSpace:colorSpace];
    
    CGColorSpaceRelease(colorSpace);
}

-(void) drawBackground:(CGRect)rect inContext:(CGContextRef)context withColorSpace: (CGColorSpaceRef) colorSpace {
    
    UIColor * redColor = UIColorFromRGB(0xFF5252);
    UIColor * blueColor = UIColorFromRGB(0x3E51B5);
    
    // Core Graphics is a state machine - You save it state so You can get back it
    // it when Your are done with custom drawings
    CGContextSaveGState(context);
    
    // You create a path object to store path - You can also draw in context, but with
    // object You have better control
    CGMutablePathRef firstLayer = CGPathCreateMutable();
    
    // this is starting point for the line
    CGPathMoveToPoint(firstLayer, nil, -20, 160);
    
    // and those are control points to make a curve - it's is Quadratic curve so
    // You add one control point
    CGPathAddQuadCurveToPoint(firstLayer, nil, 30, 129, 77, 157);
    
    // this is for Bezier curve - You add two controls points
    CGPathAddCurveToPoint(firstLayer, nil, 190, 210, 200, 70, 303, 125);
    
    CGPathAddQuadCurveToPoint(firstLayer, nil, 340, 150, 350, 150);
    CGPathAddQuadCurveToPoint(firstLayer, nil, 380, 155, 420, 145);
    CGPathAddLineToPoint(firstLayer, nil, 420, rect.size.height + 50);
    CGPathAddLineToPoint(firstLayer, nil, -20, rect.size.height + 50);
    CGPathCloseSubpath(firstLayer);
    
    CGContextAddPath(context, firstLayer);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, blueColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 100, rect.size.width, rect.size.height));
    
    // stroke width
    CGContextSetLineWidth(context, 5);
    
    // stroke for first layer
    CGContextAddPath(context, firstLayer);
    CGContextSetStrokeColorWithColor(context,redColor.CGColor);
    CGContextStrokePath(context);
    
    // second layer
    CGMutablePathRef secondLayer = CGPathCreateMutable();
    
    CGPathMoveToPoint(secondLayer, nil, 0, 190);
    CGPathAddCurveToPoint(secondLayer, nil, 160, 250, 200, 140, 303, 190);
    CGPathAddCurveToPoint(secondLayer, nil, 430, 250, 550, 170, 590, 210);
    CGPathAddLineToPoint(secondLayer, nil, 590, 230);
    CGPathAddCurveToPoint(secondLayer, nil, 300, 260, 140, 215, 0, 225);
    CGPathCloseSubpath(secondLayer);
    
    // second layer drawing
    CGContextAddPath(context, secondLayer);
    
    // drawing will be limited to specified shape
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, redColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 170, rect.size.width, 90));
    
    // stroke for second layer
    CGContextAddPath(context, secondLayer);
    CGContextSetStrokeColorWithColor(context,redColor.CGColor);
    CGContextStrokePath(context);
    
    // Cleanup Code - free memory
    CGPathRelease(secondLayer);
    CGPathRelease(firstLayer);

    // after You have finished custom drawings, You are setting context to
    // previous state
    CGContextRestoreGState(context);
}



@end
