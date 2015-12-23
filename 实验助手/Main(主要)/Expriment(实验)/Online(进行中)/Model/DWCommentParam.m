//
//  DWCommentParam.m
//  实验助手
//
//  Created by sxq on 15/12/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+JSON.h"
#import "DWCommentParam.h"
#import "SXQDBManager.h"
#import <MJExtension/MJExtension.h>
#import "DWInstructionUploadParam.h"
@implementation DWCommentParam
+ (instancetype)paramWithInstructionID:(NSString *)instructionID
{
    DWCommentParam *commentParam = [[DWCommentParam alloc] init];
    DWInstructionUploadParam *uploadInstructionData = [[SXQDBManager sharedManager] getInstructionUploadDataWithInstructionID:instructionID];
    commentParam.expInstructionJson= [NSString jsonStrWithDictionary:uploadInstructionData.mj_keyValues];
    commentParam.allowDownload = 0;
    commentParam.expInstructionID = instructionID;
    return commentParam;
}
@end
