//
//  DWAddEquipmentCell.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "SXQSupplier.h"
#import "MBProgressHUD+MJ.h"
#import "DWAddItemToolImpl.h"
#import "DWAddExpEquipment.h"
#import "DWAddEquipmentViewModel.h"
#import "DWAddEquipmentCell.h"
#import "DWTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWAddEquipmentCell ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet DWTextField *equipmentNameField;
@property (nonatomic,weak) IBOutlet DWTextField *supplierField;
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@end
@implementation DWAddEquipmentCell
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [[DWAddItemToolImpl alloc] init];
    }
    return _addItemTool;
}
- (void)setEquipmentViewModel:(DWAddEquipmentViewModel *)equipmentViewModel
{
    _equipmentViewModel = equipmentViewModel;
    [self p_bindingViewModel];
}
- (void)p_bindingViewModel
{
    RAC(self.equipmentNameField,text) = [RACObserve(self.equipmentViewModel, equipmentName) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.supplierField,text) = [RACObserve(self.equipmentViewModel,supplierName) takeUntil:self.rac_prepareForReuseSignal];
    [self bindingMoreButton];
}
- (void)bindingMoreButton
{
    [self bindingEquipmentPicker];
    [self bindingSupplierPicker];
}
- (void)bindingSupplierPicker
{
    @weakify(self)
    [[[[[self.supplierField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
    doNext:^(id x) {
        @strongify(self)
        [self dismissKeyboard];
    }]
    filter:^BOOL(id value) {
        if (self.equipmentViewModel.equipmentID) {
            return YES;
        }else
        {
            [MBProgressHUD showError:@"请选择设备"];
            return NO;
        }
    }]
    subscribeNext:^(id x) {
        @strongify(self)
        [self.addItemTool showSupplierWithOrigin:self.supplierField itemType:DWAddItemTypeEquipment itemID:self.equipmentViewModel.equipmentID handler:^(SXQSupplier *supplier) {
            self.equipmentViewModel.supplierName = supplier.supplierName;
            self.equipmentViewModel.supplierID = supplier.supplierID;
        }];
    }];
    
    
}
- (void)bindingEquipmentPicker
{
    @weakify(self)
    
    [[[[[self.equipmentNameField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     takeUntil:self.rac_prepareForReuseSignal]
    doNext:^(UIButton *button) {
        [self dismissKeyboard];
    }]
     flattenMap:^RACStream *(id value) {
         @strongify(self)
         return [self.addItemTool fetchEqupmentsSignal];
     }]
    subscribeNext:^(NSArray *equpments) {
        [self.addItemTool showEquipmentPickerWithEquipments:equpments origin:self.equipmentNameField handler:^(DWAddExpEquipment *expEquipment) {
         @strongify(self)
            self.equipmentViewModel.equipmentName = expEquipment.equipmentName;
            self.equipmentViewModel.equipmentID  = expEquipment.equipmentID;
            self.equipmentViewModel.supplierID = nil;
            self.equipmentViewModel.supplierName = nil;
        }];
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.equipmentNameField]) {
        self.equipmentViewModel.equipmentName = textField.text;
        self.equipmentViewModel.equipmentID = [NSString uuid];
        self.equipmentViewModel.supplierName = nil;
        self.equipmentViewModel.supplierID = nil;
    }else if([textField isEqual:self.supplierField])
    {
        self.equipmentViewModel.supplierName = textField.text;
        self.equipmentViewModel.supplierID = [NSString uuid];
    }
}
- (void)dismissKeyboard
{
    [self.equipmentNameField resignFirstResponder];
    [self.supplierField resignFirstResponder];
}
@end
