//
//  DWAddExperimentAssignView.m
//  实验助手
//
//  Created by sxq on 15/12/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAssignmentViewModel.h"
#import "DWAddExperimentAssignView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWAddExperimentAssignView()
@property (nonatomic,weak) IBOutlet UITextField *projectNameField;
@property (nonatomic,weak) IBOutlet UITextField *researchField;
@property (nonatomic,weak) IBOutlet UITextField *taskField;

@end

@implementation DWAddExperimentAssignView
- (void)setViewModel:(DWAssignmentViewModel *)viewModel
{
    _viewModel = viewModel;
    [self bindingViewModel];
}
- (void)bindingViewModel
{
    RAC(self.viewModel,projectName) = self.projectNameField.rac_textSignal;
    RAC(self.viewModel,researchName) = self.researchField.rac_textSignal;
    RAC(self.viewModel,researchTaskName) = self.taskField.rac_textSignal;
}
@end
