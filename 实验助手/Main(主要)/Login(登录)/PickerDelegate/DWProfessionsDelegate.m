//
//  DWProfessionsDelegate.m
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWProfessionsDelegate.h"
@interface DWProfessionsDelegate ()
@property (nonatomic,copy) void (^doneBlock)(NSDictionary *profession);
@property (nonatomic,copy) void (^cancelBlock)();
@property (nonatomic,strong) NSDictionary *profession;
@property (nonatomic,strong) NSArray *professions;
@end
@implementation DWProfessionsDelegate
- (instancetype)initWithProfessions:(NSArray *)professions doneBlock:(void (^)(NSDictionary *))doneBlock cancelBlock:(void (^)())cancelBcock
{
    if (self = [super init]) {
        self.professions = professions;
        self.profession = [professions firstObject];
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBcock;
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.professions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.professions[row] objectForKey:@"educationName"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.profession = self.professions[row];
}
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.cancelBlock();
}
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    self.doneBlock(self.profession);
}
@end
