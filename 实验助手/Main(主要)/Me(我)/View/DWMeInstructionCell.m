//
//  DWMeInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "DWMeInstructionCell.h"
#import "UIView+MJ.h"
@interface DWMeInstructionCell ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic,weak) IBOutlet UILabel *instructionNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *supplierNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *productNumLabel;
@property (nonatomic,weak) IBOutlet UIButton *uploadButtton;
@property (nonatomic,weak) IBOutlet UIButton *shareButton;
@property (nonatomic,weak) IBOutlet UIView *myContentView;
@end
@implementation DWMeInstructionCell
- (void)setInstruction:(SXQExpInstruction *)instruction
{
    _instruction = instruction;
    self.instructionNameLabel.text = instruction.experimentName;
    self.supplierNameLabel.text = instruction.supplierName;
    self.productNumLabel.text = instruction.productNum;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragCenterView:)];
    self.panRecognizer.delegate = self;
    [self.myContentView addGestureRecognizer:self.panRecognizer];
}
- (void)dragCenterView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat cellWidth = self.frame.size.width;
    
    // 结束拖拽
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.maxX <= [self buttonMidX]) { // 往右边至少走动了75
            [UIView animateWithDuration:0.3 animations:^{
                pan.view.transform = CGAffineTransformMakeTranslation(-[self totalWidth], 0);
            }];
        } else { // 走动距离的没有达到75
            [UIView animateWithDuration:0.3 animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    } else { // 正在拖拽中
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
        
        if (pan.view.maxX <= [self buttonMinX]) {
            pan.view.transform = CGAffineTransformMakeTranslation(-[self totalWidth], 0);
        } else if (pan.view.maxX >= cellWidth) {
            pan.view.transform = CGAffineTransformIdentity;
        }
    }
}
- (void)close
{
    [UIView animateWithDuration:0.3 animations:^{
            self.myContentView.transform = CGAffineTransformIdentity;
    }];
}
- (CGFloat)buttonMinX
{
    return CGRectGetMinX(self.shareButton.frame);
}
- (CGFloat)buttonMidX
{
    return CGRectGetMinX(self.uploadButtton.frame);
}
- (CGFloat)totalWidth
{
    return CGRectGetMaxX(self.uploadButtton.frame) - CGRectGetMinX(self.shareButton.frame);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (IBAction)uploadButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(instrucitonCell:didClickedUploadButton:)]) {
        [self.delegate instrucitonCell:self didClickedUploadButton:sender];
    }
}
- (IBAction)shareButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(instrucitonCell:didClickedShareButton:)]) {
        [self.delegate instrucitonCell:self didClickedShareButton:sender];
    }
}
@end
