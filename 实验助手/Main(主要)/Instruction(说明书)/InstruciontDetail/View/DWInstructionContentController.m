//
//  DWInstructionContentController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionNavViewModel.h"
#import "DWInstructionContentController.h"

@interface DWInstructionContentController ()
@property (nonatomic,strong) DWInstructionNavViewModel *viewModel;
@property (nonatomic,weak) IBOutlet UITextView *contentView;
@end

@implementation DWInstructionContentController
- (instancetype)initWithViewModel:(DWInstructionNavViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _viewModel.vcTitle;
    self.contentView.text = _viewModel.title;
}
@end
