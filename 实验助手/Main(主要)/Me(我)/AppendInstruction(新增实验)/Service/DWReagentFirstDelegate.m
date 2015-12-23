//
//  DWReagentFirstDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWReagentFirstClarify.h"
#import "DWReagentFirstDelegate.h"
@interface DWReagentFirstDelegate ()
@property (nonatomic,copy) void (^doneBlock)(id result);
@property (nonatomic,strong) NSArray *firstClarifies;
@property (nonatomic,strong) DWReagentFirstClarify *firstClarify;
@end
@implementation DWReagentFirstDelegate
- (instancetype)initWithFirstClarifies:(NSArray *)clarifies doneBlock:(void (^)(id))doneBlock
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.firstClarifies = clarifies;
        self.firstClarify = [self.firstClarifies firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.firstClarifies.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    DWReagentFirstClarify *clarify = self.firstClarifies[row];
    return clarify.levelOneSortName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.firstClarify = self.firstClarifies[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.firstClarify);
}
@end
