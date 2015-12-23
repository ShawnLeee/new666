//
//  DWInstructionModelController.m
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWInstructionModelController.h"
#import "DWAddExpInstruction.h"
#import "DWAddInstructionViewModel.h"
#import "UIBarButtonItem+MJ.h"

@interface DWInstructionModelController ()
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *instructions;
@property (nonatomic,copy) void (^completion)(DWAddInstructionViewModel *addInstructionViewModel);
@end

@implementation DWInstructionModelController
- (NSArray *)instructions
{
    if (!_instructions) {
        _instructions = @[];
    }
    return _instructions;
}
- (instancetype)initWithService:(id<DWMeService>)service completion:(void (^)(DWAddInstructionViewModel *))completion
{
    if (self = [super init]) {
        self.service = service;
        self.completion = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setTableView];
    [self p_setNavigationBar];
    [self p_loadInstructionsData];
}
- (void)p_setNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Cancel_Normal" highIcon:@"Cancel_Highlight" target:self action:@selector(disMissSelf)];
    self.title = @"选择模版";
}
- (void)p_setTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (void)p_loadInstructionsData
{
    @weakify(self)
    [[self.service localInstructions]
    subscribeNext:^(NSArray *instructions) {
        @strongify(self)
        self.instructions = instructions;
        [self.tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.instructions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWAddExpInstruction *expInstruction = self.instructions[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = expInstruction.experimentName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWAddExpInstruction *expInstruction = self.instructions[indexPath.row];
    DWAddInstructionViewModel *instructionViewModel = [[DWAddInstructionViewModel alloc] init];
    instructionViewModel.expInstruction = expInstruction;
    [instructionViewModel loadInstructionData];
    self.completion(instructionViewModel);
    [self disMissSelf];
}
- (void)disMissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
