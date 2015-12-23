//
//  DWSubCategoryDelegate.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpSubCategory.h"
#import "DWSubCategoryDelegate.h"
@interface DWSubCategoryDelegate ()
@property (nonatomic,copy) SubDoneBlock doneBlock;
@property (nonatomic,copy) CancelBlock cancelBlock;
@property (nonatomic,strong) NSArray *subcategories;
@property (nonatomic,strong) SXQExpSubCategory *subCategory;
@end
@implementation DWSubCategoryDelegate
- (instancetype)initWithDoneBlock:(SubDoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock categories:(NSArray *)subCategories
{
    if (self = [super init]) {
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
        self.subcategories = subCategories;
        self.subCategory = [subCategories firstObject];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.subcategories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SXQExpSubCategory *subCatetory = self.subcategories[row];
    return subCatetory.expSubCategoryName;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.subCategory = self.subcategories[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.subCategory);
}
@end
