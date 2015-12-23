//
//  DWCommentItemViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentItem.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWCommentItemViewModel.h"

@implementation DWCommentItemViewModel
- (instancetype)initWithCommentItem:(DWCommentItem *)commentItem
{
    if (self = [super init]) {
        _commentItem = commentItem;
        self.itemName = commentItem.itemName;
        self.commentSocres = 5;
        RAC(commentItem,itemScore) = RACObserve(self, commentSocres);
    }
    return self;
}

@end
