//
//  DWCommentHeaderViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentItem.h"
#import "DWCommentGroup.h"
#import "DWCommentItemViewModel.h"
#import "DWCommentHeaderViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentHeaderViewModel ()
@end
@implementation DWCommentHeaderViewModel
- (instancetype)initWithCommentGroup:(DWCommentGroup *)commentGroup
{
    if (self = [super init]) {
        _commentGroup = commentGroup;
        self.groupName = commentGroup.expReviewOptName;
        self.groupScore = 5;
        self.items = [self commentItemViewModelArrayWithItemArray:commentGroup.expReviewDetailOfOpts];
        [self p_bindingViewModels];
        RAC(commentGroup,expReviewOptScore) = RACObserve(self, groupScore);
    }
    return self;
}
- (NSArray *)commentItemViewModelArrayWithItemArray:(NSArray *)commentItems
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [commentItems enumerateObjectsUsingBlock:^(DWCommentItem *commentItem, NSUInteger idx, BOOL * _Nonnull stop) {
        DWCommentItemViewModel *viewModel = [[DWCommentItemViewModel alloc] initWithCommentItem:commentItem];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
- (void)p_bindingViewModels
{
    [self.items enumerateObjectsUsingBlock:^(DWCommentItemViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [self bindingWithItemViewModel:viewModel];
    }];
}
//有一个itemScore改变时更新GroupScore
- (void)bindingWithItemViewModel:(DWCommentItemViewModel *)itemViewModel
{
    @weakify(self)
    [RACObserve(itemViewModel, commentSocres)
    subscribeNext:^(id x) {
        //更新groupScores
        @strongify(self)
        [self p_updateGroupScore];
    }];
}
- (void)p_updateGroupScore
{
    __block NSInteger totalScore = 0;
    [self.items enumerateObjectsUsingBlock:^(DWCommentItemViewModel *itemViewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        totalScore += itemViewModel.commentSocres;
    }];
    self.groupScore = (NSInteger)totalScore/self.items.count;
}
@end
