//
//  DWDoingCell.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingViewModel.h"
#import "DWDoingActionBar.h"
#import "DWDoingContentView.h"

#import "DWDoingCell.h"
#import "DWButton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWDoingCell ()
@property (nonatomic,weak) IBOutlet DWDoingContentView *experimentContentView;
@property (nonatomic,weak) IBOutlet DWDoingActionBar *actionBar;
@end
@implementation DWDoingCell
- (void)awakeFromNib
{
    [self.actionBar.viewBtn addTarget:self action:@selector(previewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setViewModel:(DWDoingViewModel *)viewModel
{
    _viewModel = viewModel;
    self.experimentContentView.viewModel = viewModel;
    self.experimentContentView.cell = self;
    self.actionBar.viewModel = viewModel;
}
- (void)previewButtonClicked:(id)button
{
    if ([self.delegate respondsToSelector:@selector(doingCell:clickedPreviewButton:)]) {
        [self.delegate doingCell:self clickedPreviewButton:button];
    }
}
@end
