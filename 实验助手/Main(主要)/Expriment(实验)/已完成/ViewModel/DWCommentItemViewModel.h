//
//  DWCommentItemViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,DWCommentItem;
#import <Foundation/Foundation.h>

@interface DWCommentItemViewModel : NSObject
@property (nonatomic,strong) DWCommentItem *commentItem;

@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,assign) NSInteger commentSocres;

- (instancetype)initWithCommentItem:(DWCommentItem *)commentItem;
@end
