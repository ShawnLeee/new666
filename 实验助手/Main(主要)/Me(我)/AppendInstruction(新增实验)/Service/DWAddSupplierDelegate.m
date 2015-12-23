//
//  DWSupplierDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "DWAddSupplierDelegate.h"
@interface DWAddSupplierDelegate ()
@property (nonatomic,copy) void (^doneBlock)(id result);
@property (nonatomic,strong) SXQSupplier *selecteSupplier;
@property (nonatomic,strong) NSArray *suppliers;
@end
@implementation DWAddSupplierDelegate
- (instancetype)initWithSuppliers:(NSArray *)suppliers doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.suppliers = suppliers;
        self.selecteSupplier = [self.suppliers firstObject];
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
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selecteSupplier = self.suppliers[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.selecteSupplier);
}
@end
