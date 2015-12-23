//
//  DWCategoryDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpCategory.h"
#import "DWCategoryDelegate.h"
@interface DWCategoryDelegate()
@property (nonatomic,copy) DoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;
@property (nonatomic,strong) SXQExpCategory *expCatetory;
@property (nonatomic,strong) NSArray *catetories;

@end
@implementation DWCategoryDelegate
- (instancetype)initWithDoneBlock:(DoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock categories:(NSArray *)catetories
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
        self.catetories = catetories;
        self.expCatetory = [self.catetories firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.catetories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SXQExpCategory *catetory = self.catetories[row];
    return catetory.expCategoryName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.expCatetory = self.catetories[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.expCatetory);
}
@end
