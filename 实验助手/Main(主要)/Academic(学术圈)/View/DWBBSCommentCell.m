//
//  DWBBSCommentCell.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSCommentViewModel.h"
#import "DWBBSCommentCell.h"
@interface DWBBSCommentCell ()
@property (nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *commentContentLabel;
@property (nonatomic,weak) IBOutlet UILabel *createTimeLabel;
@end
@implementation DWBBSCommentCell
- (void)setViewModel:(DWBBSCommentViewModel *)viewModel
{
    _viewModel = viewModel;
    self.userNameLabel.text = viewModel.userName;
    self.commentContentLabel.text = viewModel.commentContent;
    self.createTimeLabel.text = viewModel.createTime;
}
@end
