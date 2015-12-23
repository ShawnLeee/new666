//
//  DWBBSCommentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSComment.h"
#import "DWBBSCommentViewModel.h"
@interface DWBBSCommentViewModel ()
@property (nonatomic,strong) id<DWBBSTool> bssTool;
@property (nonatomic,strong) DWBBSComment *comment;
@end
@implementation DWBBSCommentViewModel
- (instancetype)initWithComment:(DWBBSComment *)comment bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _bssTool = bbsTool;
        self.comment = comment;
    }
    return self;
}
- (void)setComment:(DWBBSComment *)comment
{
    _comment = comment;
    self.reviewID = comment.reviewID;
    self.userName = comment.reviewer;
    if (comment.parentReviewer.length) {
        self.commentContent = [NSString stringWithFormat:@"回复:%@ %@",comment.parentReviewer,comment.reviewDetail];
    }else
    {
        self.commentContent = comment.reviewDetail;
    }
    self.createTime = [self p_convertWithTime:comment.reviewDateTime];
}
- (NSString *)p_convertWithTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * commentDate = [dateFormatter dateFromString:time];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *commentDateStr = [dateFormatter stringFromDate:commentDate];
    return commentDateStr;
}
@end
