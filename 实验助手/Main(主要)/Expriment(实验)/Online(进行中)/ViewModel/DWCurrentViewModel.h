//
//  DWCurrentViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/24.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExperimentModel;
#import <Foundation/Foundation.h>

@interface DWCurrentViewModel : NSObject
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,assign) int currentStep;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *currentStepDesc;
@property (nonatomic,copy) NSString *notes;
@property (nonatomic,copy) NSString *reagentLocation;
@end
