//
//  DWCommentItemCell.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWCommentItemCell.h"
#import "DWCommentItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWStarView.h"
@interface DWCommentItemCell ()
@property (weak, nonatomic) IBOutlet DWStarView *starView;
@property (nonatomic,weak) IBOutlet UILabel *itemLabel;
@end
@implementation DWCommentItemCell
- (void)setViewModel:(DWCommentItemViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemLabel.text = viewModel.itemName;
    self.starView.scores = viewModel.commentSocres;
    
    @weakify(self)
    [RACObserve(self.starView,scores)
    subscribeNext:^(NSNumber *scores) {
        @strongify(self)
        self.viewModel.commentSocres = [scores integerValue];
    }];
}
@end
