//
//  DWItemCell.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWItemCell.h"
#import "DWItemCellViewModel.h"
@interface DWItemCell()
@property (nonatomic,weak) IBOutlet UILabel *itemNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *itemSupplierLabel;
@end
@implementation DWItemCell
- (void)setViewModel:(DWItemCellViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemNameLabel.text = viewModel.itemName;
    self.itemSupplierLabel.text = viewModel.supplierName;
}
@end
