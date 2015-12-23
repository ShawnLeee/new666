//
//  DWAddEquipmentDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpEquipment.h"
#import "DWAddEquipmentDelegate.h"
@interface DWAddEquipmentDelegate ()
@property (nonatomic,copy) void (^doneBlock)(id result);
@property (nonatomic,strong) NSArray *equipments;
@property (nonatomic,strong) DWAddExpEquipment *selectedItem;
@end
@implementation DWAddEquipmentDelegate
- (instancetype)initWithEquipments:(NSArray *)equipments doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.equipments = equipments;
        self.selectedItem  = [equipments firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.equipments.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DWAddExpEquipment *equpment = self.equipments[row];
    return equpment.equipmentName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedItem = self.equipments[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.selectedItem);
}
@end
