//
//  DWSupplierDelegate.m
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "DWSupplierDelegate.h"
@interface DWSupplierDelegate()
@property (nonatomic,copy) DoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;
@property (nonatomic,strong) NSArray *suppliers;
@property (nonatomic,strong) SXQSupplier *supplier;
@end
@implementation DWSupplierDelegate
- (instancetype)initWithSuppliers:(NSArray *)suppliers doneBlock:(DoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock
{
    if (self = [super init]) {
        self.suppliers = suppliers;
        self.supplier = [suppliers firstObject];
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.suppliers.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SXQSupplier *supplier = self.suppliers[row];
    return supplier.supplierName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.supplier = self.suppliers[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.supplier);
}
@end
