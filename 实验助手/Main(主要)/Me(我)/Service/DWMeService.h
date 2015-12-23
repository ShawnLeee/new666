//
//  DWMeService.h
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import <Foundation/Foundation.h>

@protocol DWMeService <NSObject>
- (RACSignal *)meItemsSignal;
- (RACSignal *)allInstructionsSignal;
- (RACSignal *)userInfoSignal;
- (RACSignal *)uploadUserProfile;
- (void)signOut;
/**
 *  同步说明书
 *
 *  @param instructionID 说明书ID
 *  @param allowDownload 0-不允许下载，1-允许下载，2-share
 *
 *  @return RACSignal of success 
 */
- (RACSignal *)uploadInstructionWithInstrucitonID:(NSString *)instructionID allowDownload:(int)allowDownload;
- (RACSignal *)addExpInstructionInstructionID:(NSString *)instructionID;
/**
 *  Get local instructions
 *
 *  @return NSArray<DWAddExpInstruction *>
 */
- (RACSignal *)localInstructions;
- (RACSignal *)changeUserIconSignalWithUserImage:(UIImage *)image;

- (RACSignal *)userIconSignal;

@end
