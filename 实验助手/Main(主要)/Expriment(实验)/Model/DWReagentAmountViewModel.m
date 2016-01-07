//
//  DWReagentAmountViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpReagent.h"
#import "DWReagentAmountViewModel.h"
#import "NSString+Check.h"
@interface DWReagentAmountViewModel ()
@property (nonatomic,strong) SXQExpReagent *reagent;
@end
@implementation DWReagentAmountViewModel
- (instancetype)initWithReagent:(SXQExpReagent *)reagent
{
    if (self = [super init]) {
        _reagent = reagent;
        [self bindingModel];
    }
    return self;
}
- (void)bindingModel
{
    self.reagentName = _reagent.reagentName;
    self.singleAmount = [NSString stringWithFormat:@"%d",_reagent.useAmount];
    self.totalAmount = [NSString stringWithFormat:@"%f %@",_reagent.totalCount,_reagent.reagentSpec];
    
    [RACObserve(self, singleAmount)
    subscribeNext:^(NSString *singleAmount) {
        if (![singleAmount dg_isNumber]) {
            if (singleAmount.length > 0 ) {
                [MBProgressHUD showError:@"请输入数字"];
            }
            return ;
        }
        self.totalAmount =[NSString stringWithFormat:@"%.0f %@",[self countTotalAmount],_reagent.reagentSpec];
    }];
    [RACObserve(self, sampleAmount)
    subscribeNext:^(NSString *amount) {
        if (![amount dg_isNumber]) {
            if (amount.length > 0 ) {
                [MBProgressHUD showError:@"请输入数字"];
            }
            return ;
        }
        self.totalAmount =[NSString stringWithFormat:@"%.0f %@",[self countTotalAmount],_reagent.reagentSpec];
        
    }];
    
    [RACObserve(self, repeatCount)
    subscribeNext:^(NSString *repeatCount) {
        if (![repeatCount dg_isNumber]) {
            if (repeatCount.length > 0) {
                [MBProgressHUD showError:@"请输入数字"];
            }
        }else
        {
            self.totalAmount =[NSString stringWithFormat:@"%.0f %@",[self countTotalAmount],_reagent.reagentSpec];
        }
        
    }];
    [RACObserve(self, totalAmount)
    subscribeNext:^(id x) {
        self.reagent.totalCount = [self countTotalAmount];
    }];
}
- (CGFloat)countTotalAmount
{
    return  [self.sampleAmount doubleValue] * [self.repeatCount doubleValue] * [self.singleAmount doubleValue];
}
@end
