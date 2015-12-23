//
//  DWBBSCommentParam.h
//  实验助手
//
//  Created by sxq on 15/12/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQBaseParam.h"
#import <Foundation/Foundation.h>

@interface DWBBSCommentParam : SXQBaseParam
@property (nonatomic,copy) NSString *topicID;
@property (nonatomic,copy) NSString *reviewerID;
@property (nonatomic,copy) NSString *reviewDetail;
@property (nonatomic,copy) NSString *parentReviewID;
+ (instancetype)paramWithTopicID:(NSString *)topicID parentReviewID:(NSString *)parentReviewID;
@end
