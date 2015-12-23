//
//  DWCommentCell.m
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentViewModel.h"
#import "DWCommentCell.h"
#import "DWStarView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentCell ()
@property (nonatomic,weak) IBOutlet UILabel *itemLabel;
@property (nonatomic,weak) IBOutlet DWStarView *starView;
@end
@implementation DWCommentCell
- (void)setViewModel:(DWCommentViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemLabel.text = viewModel.expReviewOptName;
    self.starView.viewModel = viewModel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
