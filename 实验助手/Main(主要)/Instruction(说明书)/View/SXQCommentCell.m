//
//  SXQCommentCell.m
//  实验助手
//
//  Created by sxq on 15/11/6.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReview.h"
#import "SXQCommentCell.h"
#import "SXQCommentView.h"
#import "DWStarView.h"
@interface SXQCommentCell ()
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet DWStarView *startView;
@end
@implementation SXQCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setReview:(SXQReview *)review
{
    _review = review;
    self.nameLabel.text = review.nickName;
    self.startView.scores = review.expScore;
}
@end
