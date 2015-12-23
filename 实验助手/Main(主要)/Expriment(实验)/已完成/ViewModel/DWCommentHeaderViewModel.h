//
//  DWCommentHeaderViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,DWCommentGroup;
#import <Foundation/Foundation.h>

@interface DWCommentHeaderViewModel : NSObject
@property (nonatomic,copy) NSString *groupName;

@property (nonatomic,strong) NSArray *items;

@property (nonatomic,assign) NSInteger groupScore;

@property (nonatomic,assign) BOOL opened;

@property (nonatomic,strong) DWCommentGroup *commentGroup;
- (instancetype)initWithCommentGroup:(DWCommentGroup *)commentGroup;
@end
