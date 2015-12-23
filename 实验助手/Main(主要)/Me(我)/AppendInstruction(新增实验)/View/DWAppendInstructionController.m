//
//  DWAppendInstructionController.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "MBProgressHUD+MJ.h"
#import "DWAddItemController.h"
#import "DWAddExpInstruction.h"
#import "DWAddInstructionViewModel.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWAppendInstructionController.h"
#import "DWInstructionContainer.h"
#import "DWAddInstructionServiceImpl.h"
@interface DWAppendInstructionController ()<UIScrollViewDelegate>
@property (nonatomic,weak) IBOutlet DWInstructionContainer *instructionContainer;
@property (nonatomic,strong) id<DWAddInstructionService> addInstructionService;
@end

@implementation DWAppendInstructionController
- (id<DWAddInstructionService>)addInstructionService
{
    if (!_addInstructionService) {
        _addInstructionService = [[DWAddInstructionServiceImpl alloc] init];
    }
    return _addInstructionService;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNavigationBar];
    [self p_setInstructionContainer];
}
- (void)p_setInstructionContainer
{
    if (!self.createFromModel) {
        self.addInstructionViewModel = [[DWAddInstructionViewModel alloc] init];
        self.addInstructionViewModel.expInstruction = [[DWAddExpInstruction alloc] init];
    }
    self.addInstructionViewModel.expInstruction.expInstructionID = [NSString uuid];
    self.instructionContainer.instructionViewModel = self.addInstructionViewModel.expInstruction;
    self.instructionContainer.addInstructionService = self.addInstructionService;
}
- (void)p_setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" titleColor:LABBtnBgColor font:15 action:^{
        DWAddItemController *itemController = [DWAddItemController new];
        itemController.createFromModel = self.createFromModel;
        itemController.addInstrucitonViewModel = self.addInstructionViewModel;
        if ([self messageCompleted]) {
            [self.navigationController pushViewController:itemController animated:YES];
        }
    }];
}
- (BOOL)messageCompleted
{
    DWAddExpInstruction *expInstruction = self.addInstructionViewModel.expInstruction;
    if (!expInstruction.expCategoryID)
    {
        [MBProgressHUD showError:@"请选择一级分类"];
        return NO;
    }
    if (!expInstruction.expSubCategoryID) {
        [MBProgressHUD showError:@"请选择二级分类"];
        return NO;
    }
    if (expInstruction.experimentName.length < 1) {
        [MBProgressHUD showError:@"请输入说明书名称"];
        return NO;
    }
    if ([expInstruction.experimentDesc isEqualToString:@"请输入实验简介"]) {
        [MBProgressHUD showError:@"请输入实验简介"];
        return NO;
    }
    if ([expInstruction.experimentTheory isEqualToString:@"请输入实验原理"] ) {
        [MBProgressHUD showError:@"请输入实验原理"];
        return NO;
    }
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
