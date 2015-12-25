//
//  DWAddExperimentContentView.h
//  实验助手
//
//  Created by sxq on 15/12/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction,DWAssignmentViewModel;
#import <UIKit/UIKit.h>

@interface DWAddExperimentContentView : UIView
@property (nonatomic,strong) SXQExpInstruction *expInstruction;
@property (nonatomic,strong) DWAssignmentViewModel *assignViewModel;
@end
