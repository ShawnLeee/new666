//
//  SXQInstructionStepCell.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionStepViewModel.h"
#import "SXQInstructionStep.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQInstructionStepCell.h"
#import "SXQCountTimeView.h"
@interface SXQInstructionStepCell ()<SXQCountTimeViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (nonatomic,weak) IBOutlet UIImageView *stepIcon;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) SXQCountTimeView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *stepDesc;
@property (nonatomic,assign) BOOL stepEditing;
@property (nonatomic,strong) SXQInstructionStep *instructionStep;
@end
@implementation SXQInstructionStepCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setupSelf];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupSelf];
    }
    return self;
}
- (void)p_setupSelf {
    _stepEditing = NO;
    self.timeView = [[SXQCountTimeView alloc] init];
    self.timeView.delegate = self;
}
- (void)awakeFromNib
{
    [self binding];
}
- (void)binding
{
    @weakify(self)
   [[self.timeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
      @strongify(self)
       [self.timeView show];
   }];
    
    [[[self rac_signalForSelector:@selector(countTimeView:choosedTime:) fromProtocol:@protocol(SXQCountTimeViewDelegate)]
     map:^id(RACTuple *tuple) {
         return tuple.second;
     }]
     subscribeNext:^(NSNumber *time) {
         NSTimeInterval timeInteval = [time doubleValue];
         @strongify(self)
         self.viewModel.time = [NSString stringWithFormat:@"%.0f分钟",timeInteval/60];
         [self.timeView hide];
     }];
}

- (void)setViewModel:(DWInstructionStepViewModel *)viewModel
{
    _viewModel = viewModel;
    
    self.stepIcon.image = [UIImage imageNamed:viewModel.stepIconName];
    self.editBtn.rac_command = viewModel.editCommand;
    [self p_bindingViewModel];
}
- (void)p_bindingViewModel
{
    
    @weakify(self)
    [RACObserve(self.viewModel,stepDesc)
    subscribeNext:^(NSString *stepDesc) {
        @strongify(self)
        self.stepDesc.text = stepDesc;
    }];
    [RACObserve(self.viewModel, time)
    subscribeNext:^(NSString *time) {
        @strongify(self)
        self.timeLabel.text = time;
    }];
}
@end
