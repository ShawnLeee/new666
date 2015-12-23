//
//  DWActivityIndicatorView.m
//  Activity
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 sxq. All rights reserved.
//

#import "DWActivityIndicatorView.h"
@interface DWActivityIndicatorView ()
@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic,strong) CABasicAnimation *fadeAnimation;
@end
@implementation DWActivityIndicatorView
- (CABasicAnimation *)fadeAnimation
{
    if (!_fadeAnimation) {
        _fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _fadeAnimation.duration = 0.3;
        _fadeAnimation.fillMode = kCAFillModeBoth;
    }
    return _fadeAnimation;
}
- (void)awakeFromNib
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}
- (void)showIndicator
{
    self.frame = [UIScreen mainScreen].bounds;
    self.fadeAnimation.fromValue = @(0.0);
    self.fadeAnimation.toValue = @(1.0);
    [self.layer addAnimation:self.fadeAnimation forKey:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self.indicator startAnimating];
}
- (void)hideIndicator
{
    self.fadeAnimation.fromValue = @(1.0);
    self.fadeAnimation.toValue = @(0.0);
    [self.layer addAnimation:self.fadeAnimation forKey:nil];
    [self removeFromSuperview];
    
    [self.indicator stopAnimating];
}
@end

