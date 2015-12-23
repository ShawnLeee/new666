//
//  CellContainerViewModel.h
//  实验助手
//
//  Created by SXQ on 15/10/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,SXQExpStep,DWExperimentCell;
#import "MZTimerLabel.h"
#import <Foundation/Foundation.h>
#import "SXQCountTimeView.h"
#import "SXQExperimentServices.h"
@interface CellContainerViewModel : NSObject<SXQCountTimeViewDelegate,MZTimerLabelDelegate>
/**
 *  计时器剩余时间
 */
@property (nonatomic,assign) NSTimeInterval surplusTime;

@property (nonatomic,copy) NSString *reagentLocation;
@property (nonatomic,copy) NSString *stepImageName;
@property (nonatomic,copy) NSString *stepDesc;
@property (nonatomic,copy) NSString *processMemo;
@property (nonatomic,assign) NSTimeInterval stepTime;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,assign) BOOL isUseTimer;
//启动过计时器
@property (nonatomic,assign) BOOL onceStarted;

@property (nonatomic,strong) RACCommand *timeChooseCmd;
@property (nonatomic,strong) RACCommand *addImageCommand;
@property (nonatomic,strong) RACCommand *addMemoCommand;
@property (nonatomic,strong) RACCommand *startCommand;

@property (nonatomic,assign) BOOL startButtonActive;
@property (nonatomic,weak) DWExperimentCell *cell;
@property (nonatomic,copy) void (^updateCellBlock)();
+ (instancetype)viewModelWithExpStep:(SXQExpStep *)expStep service:(id<SXQExperimentServices>)service;
- (void)addImage:(UIImage *)image;

@end
