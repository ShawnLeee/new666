//
//  DWDoingViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingModelService.h"
#import "DWMyExperimentServices.h"
@class RACCommand,SXQExperimentModel;
#import <Foundation/Foundation.h>

@interface DWDoingViewModel : NSObject
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,assign) BOOL isShowingActionBar;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,copy) NSString *expInstructionID;

@property (nonatomic,weak) UITableViewCell *cell;
@property (nonatomic,strong) id<DWDoingModelService> service;
@property (nonatomic,strong) id<DWMyExperimentServices> experimentService;

@property (nonatomic,strong) RACCommand *showActionBarCommand;
@property (nonatomic,strong) RACCommand *reportCommand;
@property (nonatomic,strong) RACCommand *viewCommand;
@property (nonatomic,strong) RACCommand *commentCommand;
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel;
@end
