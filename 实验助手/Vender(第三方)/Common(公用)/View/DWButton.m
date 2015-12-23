//
//  DWButton.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#define kImageRatio (0.6)
#define kImageWH (20)
#import "DWButton.h"

@implementation DWButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0,contentRect.size.width, contentRect.size.height * kImageRatio);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * kImageRatio, contentRect.size.width, contentRect.size.height * (1 - kImageRatio));
}
@end
