//
//  CellContainerView.m
//  实验助手
//
//  Created by sxq on 15/10/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "CellContainerViewModel.h"
#import "SXQExpStep.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PhotoContainer.h"
#import "CellContainerView.h"
#import "SXQCountTimeView.h"
#import "MZTimerLabel.h"
@interface CellContainerView ()
@property (nonatomic,weak) IBOutlet UIImageView *remakrContainer;
@property (nonatomic,weak) IBOutlet UILabel *stepDescLabel;
@property (nonatomic,weak) IBOutlet UILabel *stepMemoLabel;
@property (nonatomic,weak) IBOutlet UIImageView *stepIcon;
@property (nonatomic,strong) SXQCountTimeView *timeView;
@property (nonatomic,weak) IBOutlet PhotoContainer *photoContainer;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;
@property (nonatomic,weak) IBOutlet UIButton *chooseTimeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosViewHeightConstraint;
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,assign) BOOL didSetupContraints;
@property (nonatomic,strong) MZTimerLabel *mzLabel;
//剩余时间
//备注按钮
@property (nonatomic,strong) IBOutlet UIButton *remarkButton;
//启动按钮
@property (nonatomic,weak) IBOutlet UIButton *startButton;
@end
@implementation CellContainerView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _didSetupContraints = NO;
        [[NSBundle mainBundle] loadNibNamed:@"CellContainerView" owner:self options:nil];
        _view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_view];
        _mzLabel = [[MZTimerLabel alloc] initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeTimer];
        self.timeView = [[SXQCountTimeView alloc] init];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!_didSetupContraints) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        _didSetupContraints = YES;
    }
    [super updateConstraints];
    
}
- (void)setViewModel:(CellContainerViewModel *)viewModel
{
    
    _viewModel = viewModel;
    _mzLabel.delegate = viewModel;
    self.timeView.delegate = viewModel;
    self.photoContainer.viewModel = viewModel;
    //unchaged Property
    
    self.stepIcon.image = [UIImage imageNamed:viewModel.stepImageName];
    self.stepDescLabel.text = viewModel.stepDesc;
    
    @weakify(self)
    
    [RACObserve(viewModel, processMemo) subscribeNext:^(NSString *processMemo) {
        @strongify(self)
        self.stepMemoLabel.text = processMemo;
    }];
    [RACObserve(viewModel, stepTime) subscribeNext:^(NSNumber *stepTime) {
        @strongify(self)
        [self.mzLabel reset];
        if (viewModel.onceStarted) {
            [self.mzLabel setCountDownTime:viewModel.surplusTime];
        }else
        {
            [self.mzLabel setCountDownTime:[stepTime doubleValue]];
        }
    }];
    [RACObserve(viewModel, isUseTimer) subscribeNext:^(NSNumber *isUseTimer) {
        @strongify(self)
        self.chooseTimeBtn.enabled = ![isUseTimer boolValue];
         if([isUseTimer boolValue]) {
             if (self.viewModel.stepTime == 0) {
             }
             [self.mzLabel start];
             _timeLabel.textColor = [UIColor redColor];
         }else
         {
             [_mzLabel pause];
             _timeLabel.textColor = [UIColor blackColor];
         }
        self.startButton.selected = [isUseTimer boolValue];
    }];
//    RAC(self.startButton,enabled) = RACObserve(viewModel, startButtonActive);
    [RACObserve(viewModel, images) subscribeNext:^(NSMutableArray *images) {
        @strongify(self)
        CGSize photoSize = [PhotoContainer photosViewSizeWithPhotosCount:images.count];
        self.photosViewHeightConstraint.constant = photoSize.height;
    }];
    
    self.chooseTimeBtn.rac_command = viewModel.timeChooseCmd;
    [[self.chooseTimeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self)
        [self.timeView show];
    }];
    self.remarkButton.rac_command = viewModel.addMemoCommand;
    
    self.startButton.rac_command = viewModel.startCommand;
}
- (void)awakeFromNib
{
    self.remakrContainer.image = [[UIImage imageNamed:@"common_card_background_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end














