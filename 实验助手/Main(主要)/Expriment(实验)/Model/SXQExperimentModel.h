//
//  SXQExperimentModel.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQExperimentModel : NSObject
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,assign) int expState;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,copy) NSString *createMonth;
@property (nonatomic,copy) NSString *reportName;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *finishTime;
@property (nonatomic,copy) NSString *reportServerPath;
@property (nonatomic,assign) int isUpload;
@property (nonatomic,copy) NSString *expVersion;
@property (nonatomic,assign) int isReviewed;
@property (nonatomic,assign) int isCreateReport;
@property (nonatomic,copy) NSString *expMeno;
@property (nonatomic,copy) NSString *createYear;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *reportLocation;
@end
