//
//  DWBBSCommentViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSComment;
#import "DWBBSTool.h"
#import <Foundation/Foundation.h>

@interface DWBBSCommentViewModel : NSObject
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *commentContent;
@property (nonatomic,copy) NSString *reviewID;
- (instancetype)initWithComment:(DWBBSComment *)comment bbsTool:(id<DWBBSTool>)bbsTool;
@end
