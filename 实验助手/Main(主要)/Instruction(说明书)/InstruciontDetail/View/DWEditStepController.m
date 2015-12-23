//
//  DWEditStepController.m
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWInstructionStepViewModel.h"
#import "DWEditStepController.h"
#import "UIBarButtonItem+SXQ.h"

@interface DWEditStepController ()
@property (nonatomic,strong) DWInstructionStepViewModel *viewModel;
@property (nonatomic,strong) id<DWInstructionService> service;
@property (nonatomic,weak) IBOutlet UITextView *textView;
@end

@implementation DWEditStepController
- (instancetype)initWithViewModel:(DWInstructionStepViewModel *)viewModel service:(id<DWInstructionService>)service
{
    if (self = [super init]) {
        _viewModel = viewModel;
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    [self p_bindingViewModel];
}
- (void)p_setupSelf
{
    self.title = @"实验步骤";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" action:^{
        [self.navigationController popViewControllerAnimated:YES];
//#warning save
//        [self.textView resignFirstResponder];
    }];
}
- (void)p_bindingViewModel
{
    self.textView.text = _viewModel.stepDesc;
    @weakify(self)
    [self.textView.rac_textSignal
    subscribeNext:^(NSString *text) {
        @strongify(self)
        self.viewModel.stepDesc = text;
    }];
}
@end
