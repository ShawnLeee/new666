//
//  DWCommentParam.h
//  实验助手
//
//  Created by sxq on 15/12/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQBaseParam.h"

@interface DWCommentParam : SXQBaseParam
@property (nonatomic,copy) NSString *expInstructionJson;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,assign) int allowDownload;
+ (instancetype)paramWithInstructionID:(NSString *)instructionID;
@end
