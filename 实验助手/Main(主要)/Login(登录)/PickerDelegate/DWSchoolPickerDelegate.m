//
//  DWSchoolPickerDelegate.m
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWSchoolPickerDelegate.h"
@interface DWSchoolPickerDelegate ()
@property (nonatomic,strong) NSArray *schools;
@property (nonatomic,strong) NSDictionary *school;
@property (nonatomic,copy) SchoolDoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;
@end
@implementation DWSchoolPickerDelegate
- (instancetype)initWithSchools:(NSArray *)schools doneBlock:(SchoolDoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock
{
    if (self = [super init]) {
        self.schools = schools;
        self.school = schools[0];
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
    return self.schools.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.schools[row] objectForKey:@"collegeName"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.school = self.schools[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.school);
}
@end
