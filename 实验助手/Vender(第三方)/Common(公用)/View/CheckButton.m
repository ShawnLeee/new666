//
//  CheckButton.m
//  CheckButton
//
//  Created by SXQ on 15/12/7.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "CheckButton.h"

@implementation CheckButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _checked = NO;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGFloat lineWidth = 2;
    CGFloat padding = 5;
    CGFloat centerXY = rect.size.width/2;
    CGFloat radius = (rect.size.width - lineWidth)/2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineCap(context, kCGLineCapButt);
    [[UIColor lightGrayColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    
    if (self.checked) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, centerXY, centerXY, radius+lineWidth/2, 0, 360, 0);
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        
        CGMutablePathRef checkPath = CGPathCreateMutable();
        CGPathMoveToPoint(checkPath, NULL, centerXY/2, centerXY);
        CGPathAddLineToPoint(checkPath, NULL, centerXY, rect.size.height - padding - 3);
        CGPathAddLineToPoint(checkPath, NULL, rect.size.width - padding,centerXY - padding);
        CGContextAddPath(context, checkPath);
        [[UIColor whiteColor] setStroke];
        CGContextStrokePath(context);
        CGPathRelease(path);
        CGPathRelease(checkPath);
    }else
    {
        CGContextAddArc(context, centerXY, centerXY, radius, 0, 360, 0);
        CGContextStrokePath(context);
    }
}
- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    [self setNeedsDisplay];
}
//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    self.checked = selected;
//}
@end
