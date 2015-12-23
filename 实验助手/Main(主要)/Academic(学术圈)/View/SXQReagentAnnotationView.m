//
//  SXQReagentAnnotationView.m
//  实验助手
//
//  Created by sxq on 15/12/3.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReagentDescView.h"
#import "SXQReagentAnnotation.h"
#import "SXQReagentAnnotationView.h"
#import "UIView+MJ.h"
@interface SXQReagentAnnotationView ()
@property (nonatomic,weak) SXQReagentDescView *descView;
@end
@implementation SXQReagentAnnotationView
+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView
{
    static NSString *ID = @"reagent_desc";
    SXQReagentAnnotationView *annotationView = (SXQReagentAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!annotationView) {
        annotationView = [[SXQReagentAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    return annotationView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        SXQReagentDescView *descView = [SXQReagentDescView reagentDescView];
        descView.frame = CGRectMake(0, 0, 100, 80);
        _descView = descView;
        self.frame = descView.frame;
        [self addSubview:descView];
    }
    return self;
}
- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    if ([annotation isKindOfClass:[SXQReagentAnnotation class]]) {
        SXQReagentAnnotation *anno = annotation;
        self.descView.adjacentUser = anno.adjacentUser;
    }
}
- (void)didMoveToSuperview
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.values = @[@0,@1.5,@1,@1.5,@1];
    anim.duration = 0.5;
    [self.layer addAnimation:anim forKey:nil];
}
@end
