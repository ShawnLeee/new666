//
//  DWAddStepViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,DWAddExpStep;
#import <Foundation/Foundation.h>

@interface DWAddStepViewModel : NSObject
@property (nonatomic,assign) NSUInteger stepNum;
@property (nonatomic,copy) NSString *stepContent;
@property (nonatomic,copy) NSString *stepTimeStr;
@property (nonatomic,copy) NSString *stepImageName;
@property (nonatomic,strong) RACCommand *chooseTimeCommand;

@property (nonatomic,strong) DWAddExpStep *addExpStep;

@property (nonatomic,weak) NSIndexPath *indexPath;
- (instancetype)initWithInstructionID:(NSString *)instructionID;
- (instancetype)initWithModel:(DWAddExpStep *)stepModel;
@end
