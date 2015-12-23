//
//  DWInstructionStepViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,SXQInstructionStep;
#import <Foundation/Foundation.h>
#import "DWInstructionService.h"
@interface DWInstructionStepViewModel : NSObject
@property (nonatomic,copy) NSString *stepIconName;
@property (nonatomic,copy) NSString *stepDesc;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,strong) RACCommand *editCommand;

- (instancetype)initWithInstructionStep:(SXQInstructionStep *)instrucitonStep service:(id<DWInstructionService>)service;
@end
