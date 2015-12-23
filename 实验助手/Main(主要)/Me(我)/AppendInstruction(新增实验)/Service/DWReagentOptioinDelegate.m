//
//  DWReagentOptioinDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWReagentOption.h"
#import "DWReagentOptioinDelegate.h"
@interface DWReagentOptioinDelegate ()
@property (nonatomic,strong) NSArray *reagentOptions;
@property (nonatomic,copy) void (^doneBlock)(id result);
@property (nonatomic,strong) DWReagentOption *reagentOption;
@end
@implementation DWReagentOptioinDelegate
- (instancetype)initWithReagentOptions:(NSArray *)reagentOptions doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.reagentOptions = reagentOptions;
        self.reagentOption = [self.reagentOptions firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.reagentOptions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DWReagentOption *reagentOption = self.reagentOptions[row];
    return reagentOption.reagentName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.reagentOption = self.reagentOptions[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.reagentOption);
}
@end
