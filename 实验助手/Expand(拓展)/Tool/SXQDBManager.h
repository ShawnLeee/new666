//
//  SXQDBManager.h
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction,SXQInstructionData,SXQCurrentExperimentData,SXQExperimentModel,SXQInstructionDetail,DWAddInstructionViewModel,DWInstructionUploadParam;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void  (^CompletionHandler)(BOOL success,NSDictionary *info);
typedef NS_ENUM(NSUInteger,ExperimentState) {
    ExperimentStateDoing = 0,
    ExperimentStateSuspend = 1,
    ExperimentStateDown = 2,
    ExperimentStateReprot = 3,
};
@interface SXQDBManager : NSObject
+ (instancetype)sharedManager;
/**
 *  下载说明书
 */
- (void)insertInstruciton:(SXQInstructionData *)instructionData completion:(CompletionHandler)completion;
/**
 *   检查说明书是否已经下载
 */
- (BOOL)expInstrucitonExist:(NSString *)expInstructionID;

- (NSArray *)chechAllInstuction;
- (BOOL)writeRemark:(NSString *)remark withExpId:(NSString *)expId expProcessID:(NSString *)expProcessId;

- (BOOL)insertIntoMyExp:(NSString *)instrucitonID;
/**
 *  添加我的实验试剂表
 *
 */
- (BOOL)addReagentWithInstructionId:(NSString *)instructionid;
/**
 *   根据试剂ID查询供应商
 *
 *  @return [SXQSupplier] 数组
 */
- (NSArray *)querySupplierWithReagetID:(NSString *)reagentID;
/**
 *  添加实验
 */
- (void)addExpWithInstructionData:(SXQInstructionData *)instructionData completion:(void (^)(BOOL success,SXQExperimentModel *experiment))completion;
/**
 *  根据我的实验ID获取正在我的实验
 *
 *  @param myExpId     我的实验ID
 */
- (void)loadCurrentDataWithMyExpId:(NSString *)myExpId completion:(void (^)(SXQCurrentExperimentData *currentExprimentData))completioin;
/**
 *  实验步骤备注
 *
 */
- (void)updateMyExpProcessMemoWithExpProcessID:(NSString *)myExpProcessId processMemo:(NSString *)memo;
/**
 *  添加图片到对应步骤
 */
- (void)addImageWithMyExpId:(NSString *)myExpId expInstructionId:(NSString *)expInstructionId expStepId:(NSString *)expStepId image:(UIImage *)image;
/**
 *  根据说明书ID加载说明书数据
 */
- (SXQInstructionData *)fetchInstuctionDataWithInstructionID:(NSString *)instructionID;
/**
 *  获取我的实验
 */
- (NSArray *)fetchExperimentWithState:(ExperimentState)state;
/**
 *  同步实验
 */
- (NSDictionary *)getMyExpDataWithMyExpId:(NSString *)myexpid;
- (BOOL)saveInstructionWithInstructionDetail:(SXQInstructionDetail *)instructionDetail succeed:(void (^)(BOOL succeed))succeed;
- (void)saveInstructionWithDWAddInstructionViewModel:(DWAddInstructionViewModel *)addInstructionViewModel completion:(void (^)(BOOL success))completion;
/**
 *  完成实验
 */
- (BOOL)fulfillExperimentWithMyExpId:(NSString *)myExpId;

- (NSArray *)meAllInstructions;
/**
 *  查询本地实验
 */
- (NSArray *)allInstructionsOfMine:(BOOL)isMine;
/**
 *  获取同步说明书数据
 */
- (DWInstructionUploadParam *)getInstructionUploadDataWithInstructionID:(NSString *)instructionID;
- (NSArray *)localInstructions;
- (void)loadDataWithDWaddInstructionViewModel:(DWAddInstructionViewModel *)instructionViewModel;
@end






