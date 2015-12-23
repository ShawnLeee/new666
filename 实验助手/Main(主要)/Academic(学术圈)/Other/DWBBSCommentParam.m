//
//  DWBBSCommentParam.m
//  实验助手
//
//  Created by sxq on 15/12/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWBBSCommentParam.h"

@implementation DWBBSCommentParam
+ (instancetype)paramWithTopicID:(NSString *)topicID parentReviewID:(NSString *)parentReviewID
{
    DWBBSCommentParam *param = [DWBBSCommentParam new];
    param.topicID = topicID;
    param.parentReviewID = parentReviewID;
    return param;
}
- (NSString *)reviewerID
{
    if (!_reviewerID) {
        _reviewerID = self.userID;
    }
    return _reviewerID;
}
@end
