//
//  DWAddConsumableCell.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWAddExpConsumable.h"
#import "SXQSupplier.h"
#import "DWAddConsumabelViewModel.h"
#import "DWAddConsumableCell.h"
#import "DWTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+MJ.h"
#import "NSString+Check.h"
#import "MBProgressHUD+MJ.h"
#import "DWAddItemToolImpl.h"
@interface DWAddConsumableCell ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet DWTextField *consumableNameField;
@property (nonatomic,weak) IBOutlet UITextField *amountField;
@property (nonatomic,weak) IBOutlet DWTextField *supplierField;
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@end
@implementation DWAddConsumableCell
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [[DWAddItemToolImpl alloc] init];
    }
    return _addItemTool;
}
- (void)setConsumableViewModel:(DWAddConsumabelViewModel *)consumableViewModel
{
    _consumableViewModel = consumableViewModel;
    RAC(self.consumableNameField,text) = [RACObserve(self.consumableViewModel, consumableName) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.supplierField,text) = [RACObserve(self.consumableViewModel, supplierName) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.consumableViewModel,amout) = [[[[self.amountField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal ]
                                           doNext:^(NSString *amountText) {
                                               if (![amountText dg_isNumber]) {
                                                   [MBProgressHUD showError:@"请输入数字"];
                                               }
                                           }]
                                           filter:^BOOL(NSString *amountText) {
                                               return [amountText dg_isNumber];
                                           }]
                                           map:^id(NSString *amountText) {
                                               return @([amountText integerValue]);
                                           }];
    [self bindingMoreButton];
}
- (void)bindingMoreButton
{
    [self bindingMoreConsumable];
    [self bindingMoreSupplier];
}
- (void)bindingMoreConsumable
{
    @weakify(self);
    [[[[[self.consumableNameField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
    doNext:^(id x) {
        [self dismissKeyboard];
    }]
    flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self.addItemTool fetchConsumablesSignal];
    }]
    subscribeNext:^(NSArray *consumbles) {
        @strongify(self)
        [self.addItemTool showConsumablePickerWithConsumables:consumbles origin:self.consumableNameField handler:^(DWAddExpConsumable *expConsumable) {
            self.consumableViewModel.consumableName = expConsumable.consumableName;
            self.consumableViewModel.consumableID = expConsumable.consumableID;
            self.consumableViewModel.supplierName = nil;
            self.consumableViewModel.supplierID = nil;
        }];
    }];
}
- (void)bindingMoreSupplier
{
    @weakify(self)
    [[[[[self.supplierField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
    doNext:^(id x) {
        [self dismissKeyboard];
    }]
     filter:^BOOL(id value) {
         if (self.consumableViewModel.consumableID) {
             return YES;
         }else
         {
             [MBProgressHUD showError:@"请选择耗材"];
             return NO;
         }
     }]
    subscribeNext:^(id x) {
        @strongify(self)
        [self.addItemTool showSupplierWithOrigin:self.supplierField itemType:DWAddItemTypeConsumable itemID:self.consumableViewModel.consumableID handler:^(SXQSupplier *supplier) {
            self.consumableViewModel.supplierName = supplier.supplierName;
            self.consumableViewModel.supplierID = supplier.supplierID;
        }];
    }];
}
- (void)dismissKeyboard
{
    [self.consumableNameField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.supplierField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.consumableNameField]) {
        self.consumableViewModel.consumableName = textField.text;
        self.consumableViewModel.consumableID = [NSString uuid];
        self.consumableViewModel.supplierID = nil;
        self.consumableViewModel.supplierName = nil;
    }else if([textField isEqual:self.supplierField])
    {
        self.consumableViewModel.supplierName = textField.text;
        self.consumableViewModel.supplierID = [NSString uuid];
    }
}
@end
