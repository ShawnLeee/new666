//
//  DWExperimentCell.m
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWExperimentCell.h"
#import "CellContainerView.h"
#import "CellContainerViewModel.h"
@interface DWExperimentCell ()
@property (nonatomic,weak) IBOutlet CellContainerView *containerView;
@end
@implementation DWExperimentCell
- (void)setViewModel:(CellContainerViewModel *)viewModel
{
    _viewModel = viewModel;
    _containerView.viewModel = viewModel;
    viewModel.cell = self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
