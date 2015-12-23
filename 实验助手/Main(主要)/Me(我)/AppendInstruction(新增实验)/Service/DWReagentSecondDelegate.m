//
//  DWReagentSecondDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWReagentSecondClarify.h"
#import "DWReagentSecondDelegate.h"
@interface DWReagentSecondDelegate ()
@property (nonatomic,strong) void (^doneBlock)(id result);
@property (nonatomic,strong) NSArray *secondClarifies;
@property (nonatomic,strong) DWReagentSecondClarify *secondClarify;
@end
@implementation DWReagentSecondDelegate
- (instancetype)initWithSecondClarifies:(NSArray *)secondClarifies doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.secondClarifies = secondClarifies;
        self.secondClarify = [self.secondClarifies firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.secondClarifies.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DWReagentSecondClarify *clarify = self.secondClarifies[row];
    return clarify.levelTwoSortName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.secondClarify = self.secondClarifies[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.secondClarify);
}
@end
