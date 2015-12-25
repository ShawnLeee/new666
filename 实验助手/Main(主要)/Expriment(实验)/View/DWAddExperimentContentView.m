//
//  DWAddExperimentContentView.m
//  实验助手
//
//  Created by sxq on 15/12/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExperimentContainerView.h"
#import "DWAddExperimentContentView.h"
#import "DWAddExperimentAssignView.h"
#import "DWAssignmentViewModel.h"
@interface DWAddExperimentContentView ()
@property (nonatomic,weak) IBOutlet DWAddExperimentContainerView *experimentContainer;
@property (nonatomic,weak) IBOutlet DWAddExperimentAssignView *assignmentView;

@end
@implementation DWAddExperimentContentView
- (void)setExpInstruction:(SXQExpInstruction *)expInstruction
{
    _expInstruction = expInstruction;
    self.experimentContainer.expInstruction = expInstruction;
}
- (void)setAssignViewModel:(DWAssignmentViewModel *)assignViewModel
{
    _assignViewModel = assignViewModel;
    self.assignmentView.viewModel = assignViewModel;
}
@end
