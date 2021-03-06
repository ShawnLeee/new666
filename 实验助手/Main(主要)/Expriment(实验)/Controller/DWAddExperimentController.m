//
//  DWAddExperimentController.m
//  实验助手
//
//  Created by sxq on 15/12/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExperimentContentView.h"
#import "DWAddExperimentController.h"
#import "SXQInstructionData.h"
#import "DWAssignmentViewModel.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQReagentListController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpInstruction.h"
@interface DWAddExperimentController ()
@property (nonatomic,weak) IBOutlet DWAddExperimentContentView *contentView;
@property (nonatomic,strong) DWAssignmentViewModel *assignViewModel;
@end

@implementation DWAddExperimentController
- (void)p_addGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.expInstruction = self.instructionData.expInstructionMain;
    self.assignViewModel = [[DWAssignmentViewModel alloc] init];
    self.contentView.assignViewModel = self.assignViewModel;
    [self setNavigationBar];
    [self bindingViewModel];
    [self p_addGesture];
    [self p_addKeyboardNotification];
}
- (void)p_addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *info = aNotification.userInfo;
    CGFloat contentMaxY = CGRectGetMaxY(self.contentView.frame);
    CGRect  keyBoardFinalRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animTime = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (contentMaxY > keyBoardFinalRect.origin.y) {
        [UIView animateWithDuration:animTime animations:^{
            self.contentView.transform = CGAffineTransformMakeTranslation(0, -keyBoardFinalRect.size.height);
        }];
    }
}
- (void)keyBoardWillHide:(NSNotification *)aNotification
{
     NSDictionary *info = aNotification.userInfo;
    CGFloat animTime = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animTime animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)bindingViewModel
{
    [RACObserve(self.assignViewModel, projectName)
    subscribeNext:^(NSString *projectName) {
        self.instructionData.expInstructionMain.projectName = projectName;
    }];
    [RACObserve(self.assignViewModel, researchName) subscribeNext:^(NSString *researchName) {
        self.instructionData.expInstructionMain.researchName = researchName;
    }];
    [RACObserve(self.assignViewModel, researchTaskName) subscribeNext:^(NSString *taskName) {
        self.instructionData.expInstructionMain.taskName = taskName;
    }];
}
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" action:^{
        SXQReagentListController *listVC = [[SXQReagentListController alloc] initWithExpInstructionData:self.instructionData];
        [self.navigationController pushViewController:listVC animated:YES];
    }];
}

@end
