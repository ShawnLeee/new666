//
//  DWAddConsumableDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpConsumable.h"
#import "DWAddConsumableDelegate.h"
@interface DWAddConsumableDelegate ()
@property (nonatomic,copy) void (^doneBlock)(id resutlt);
@property (nonatomic,strong) DWAddExpConsumable *expConsumable;
@property (nonatomic,strong) NSArray *consumables;
@end
@implementation DWAddConsumableDelegate
- (instancetype)initWithConsumables:(NSArray *)consumables doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.consumables = consumables;
        self.expConsumable = [self.consumables firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.consumables.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DWAddExpConsumable *consumable = self.consumables[row];
    return consumable.consumableName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.expConsumable = self.consumables[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.expConsumable);
}
@end
