//
//  DWReviewDetailCell.m
//  实验助手
//
//  Created by sxq on 15/11/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQReviewItem.h"
#import "DWStarView.h"
#import "DWReviewDetailCell.h"
@interface DWReviewDetailCell ()
@property (nonatomic,weak) IBOutlet UILabel *itemLabel;
@property (nonatomic,weak) IBOutlet DWStarView *starView;
@end
@implementation DWReviewDetailCell
- (void)setReviewItem:(SXQReviewItem *)reviewItem
{
    _reviewItem = reviewItem;
    self.itemLabel.text = reviewItem.expReviewOptName;
    self.starView.scores = reviewItem.reviewOptScore;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
