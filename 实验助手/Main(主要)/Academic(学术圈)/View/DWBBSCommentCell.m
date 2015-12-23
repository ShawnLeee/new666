//
//  DWBBSCommentCell.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSCommentViewModel.h"
#import "DWBBSCommentCell.h"
#import <UIImageView+WebCache.h>
@interface DWBBSCommentCell ()
@property (nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *commentContentLabel;
@property (nonatomic,weak) IBOutlet UILabel *createTimeLabel;
@property (nonatomic,weak) IBOutlet UIImageView *iconView;

@end
@implementation DWBBSCommentCell
- (void)setViewModel:(DWBBSCommentViewModel *)viewModel
{
    _viewModel = viewModel;
    self.userNameLabel.text = viewModel.userName;
    self.commentContentLabel.text = viewModel.commentContent;
    self.createTimeLabel.text = viewModel.createTime;
    UIImage *placeHolderImage = [UIImage imageNamed:@"avatar_default"];
    [self.iconView sd_setImageWithURL:viewModel.imageUrl placeholderImage:placeHolderImage];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.height/2;
    self.iconView.clipsToBounds = YES;
}
@end
