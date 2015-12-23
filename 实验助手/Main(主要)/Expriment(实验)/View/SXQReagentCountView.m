//
//  SXQReagentCountView.m
//  实验助手
//
//  Created by sxq on 15/10/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQReagentCountView.h"
#import "SXQExpReagent.h"

#define kPerWidth  (([UIScreen mainScreen].bounds.size.width - 20)/5.0)
#define kItemFont [UIFont systemFontOfSize:15]
@interface SXQReagentCountView ()
@property (nonatomic,weak) UILabel *reagentName;
@property (nonatomic,weak) UILabel *reagentCount;
@property (nonatomic,weak) UITextField *sampleCount;
@property (nonatomic,weak) UITextField *repeatCount;
@property (nonatomic,weak) UILabel *totalCount;
@end
@implementation SXQReagentCountView
- (instancetype)init
{
    if (self = [super init]) {
//        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addCostomViews];
        [self layoutCustomView];
        
    }
    return self;
}
- (void)addCostomViews
{
    UILabel *reagentName = [[UILabel alloc] init];
    reagentName.font = kItemFont;
    reagentName.numberOfLines = 0;
    _reagentName = reagentName;
    [self addSubview:_reagentName];
    
    UILabel *reagentCount = [[UILabel alloc] init];
    reagentCount.font = kItemFont;
    reagentCount.textAlignment = NSTextAlignmentCenter;
    _reagentCount = reagentCount;
    [self addSubview:reagentCount];
    
    UITextField *sampleCount = [[UITextField alloc] init];
    sampleCount.borderStyle = UITextBorderStyleRoundedRect;
    sampleCount.keyboardType = UIKeyboardTypeDecimalPad;
    _sampleCount = sampleCount;
    [self addSubview:sampleCount];
    
    UITextField *repeatCount = [[UITextField alloc] init];
    repeatCount.keyboardType = UIKeyboardTypeDecimalPad;
    repeatCount.borderStyle = UITextBorderStyleRoundedRect;
    _repeatCount = repeatCount;
    [self addSubview:_repeatCount];
    
    UILabel *totalCount = [[UILabel alloc] init];
    totalCount.font = kItemFont;
    totalCount.textAlignment = NSTextAlignmentLeft;
    _totalCount = totalCount;
    [self addSubview:totalCount];
}
- (void)setReagent:(SXQExpReagent *)reagent
{
    _reagent = reagent;
    self.reagentName.text = reagent.reagentName;
    self.reagentCount.text =[NSString stringWithFormat:@"%d",reagent.useAmount];
    [self bindingModel];
}
- (void)bindingModel
{
    RAC(self.reagent,totalCount) = [self userAmountSignal];
    [RACObserve(self.reagent, totalCount)
     subscribeNext:^(NSNumber *amount) {
        self.totalCount.text = [NSString stringWithFormat:@"%@",amount];
    }];
}

- (RACSignal *)userAmountSignal
{
    RACSignal *sampleCountSignal = self.sampleCount.rac_textSignal;
    RACSignal *repeatCountSignal = self.repeatCount.rac_textSignal;
    RACSignal *userAmountSignal = [RACSignal combineLatest:@[sampleCountSignal,repeatCountSignal]
                                   reduce:^id(NSString *sampleCount,NSString *repeatCount){
                                       return @([sampleCount doubleValue] * [repeatCount doubleValue] * _reagent.useAmount);
                                   }];
    return userAmountSignal;
}
- (void)layoutCustomView
{
    self.reagentName.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kPerWidth]];
    
    self.reagentCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentCount attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.reagentName attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentCount attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentCount attribute:NSLayoutAttributeLastBaseline relatedBy:NSLayoutRelationEqual toItem:self.reagentName attribute:NSLayoutAttributeLastBaseline multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.reagentCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kPerWidth]];
    
    self.sampleCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sampleCount attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.reagentCount attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sampleCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.sampleCount addConstraint:[NSLayoutConstraint constraintWithItem:self.sampleCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kPerWidth - 10]];

    self.repeatCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.repeatCount attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.sampleCount attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.repeatCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.repeatCount addConstraint:[NSLayoutConstraint constraintWithItem:self.repeatCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kPerWidth- 10]];
    
    self.totalCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalCount attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.repeatCount attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalCount attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.totalCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.totalCount addConstraint:[NSLayoutConstraint constraintWithItem:self.totalCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kPerWidth]];
    
    [self layoutIfNeeded];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
  
}
@end
