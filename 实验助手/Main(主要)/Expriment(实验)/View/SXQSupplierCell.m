//
//  SXQSupplierCell.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQSupplierCell.h"
#import "SXQSupplierViewModel.h"
#import "SXQSupplier.h"
#define kDefaultBtnTitle @"选择厂商"
@interface SXQSupplierCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *supplierBtn;
@end
@implementation SXQSupplierCell
- (void)setViewModel:(SXQSupplierViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemLabel.text = viewModel.itemName;
   
   [[RACObserve(self.viewModel, supplier)
     takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(SXQSupplier *supplier) {
         [self.supplierBtn setTitle:supplier.supplierName forState:UIControlStateNormal];
     } ];
    self.supplierBtn.rac_command = viewModel.chooseSupplierCommand;
}

@end
