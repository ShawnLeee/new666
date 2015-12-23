//
//  DWSignUpViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWProfessionsDelegate.h"
#import "DWSchoolPickerDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWSignUpServiceImpl.h"
#import "DWZonePickerDelegate.h"
#import "DWSignUpServiceImpl.h"
#import <ActionSheetPicker.h>
#import "DWSignUpViewModel.h"
@interface DWSignUpViewModel ()
@end
@implementation DWSignUpViewModel
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!self.shouldBeginEditing) {
        [self.service dismissKeyBoard];
    }
    switch (self.fieldType) {
        case SignUpFieldTypeZone:
            [self showZone:textField];
            break;
        case SignUpFieldTypeInput:
            break;
        case SignUpFieldTypeSchool:
            [self showSchool:textField];
            break;
        case SignUpFieldTypeDegree:
            [self showDegree:textField];
            break;
        case SignUpFieldTypeProfession:
            [self showProfession:textField];
            break;
        case SignUpFieldTypeIdentity:
            break;
        case SignUpFieldTypeUserName:
            break;
        case SignUpFieldTypeEmail:
            break;
        case SignUpFieldTypePassword:
            break;
        case SignUpFieldTypeRePassWord:
            break;
            
    }
    return self.shouldBeginEditing;
}
- (void)showDegree:(UITextField *)sender
{
    NSArray *degrees = @[@"本科",@"硕士",@"博士"];
    [ActionSheetStringPicker showPickerWithTitle:@"选择学历" rows:degrees initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, NSString *selectedValue) {
        sender.text = selectedValue;
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:sender];
}
- (void)showZone:(UITextField *)textfield
{
    DWZonePickerDelegate *zoneDelegate = [[DWZonePickerDelegate alloc] initWithDoneBlock:^(NSDictionary *province, NSDictionary *city) {
        NSString *zoneStr = [NSString stringWithFormat:@"%@  %@",province[@"name"],city[@"name"]];
        self.text = zoneStr;
        self.service.location.provinceId = @"";
        self.service.location.cityID = @"";
    } cancelBlock:^{
    }];
    [ActionSheetCustomPicker showPickerWithTitle:@"" delegate:zoneDelegate showCancelButton:YES origin:textfield];
}
- (void)showSchool:(UITextField *)sender
{
    [[[self.service schoolsSignal]
     doNext:^(id x) {
         [self.service disableAction];
     }]
     subscribeNext:^(NSArray *schools) {
        DWSchoolPickerDelegate *schoolDelegate = [[DWSchoolPickerDelegate alloc] initWithSchools:schools
                                                                                       doneBlock:^(NSDictionary *school) {
                                                                                           self.text = school[@"collegeName"];
                                                                                           [self.service enableAction];
                                                                                                    }
                                                                                     cancelBlock:^{
                                                                                           [self.service enableAction];
                                                                                     }];
        [ActionSheetCustomPicker showPickerWithTitle:@"" delegate:schoolDelegate showCancelButton:YES origin:sender];
    }];
}
- (void)showProfession:(UITextField *)sender
{
    [[[self.service professionsSingal]
     doNext:^(id x) {
         [self.service disableAction];
     }]
    subscribeNext:^(NSArray *professions) {
        DWProfessionsDelegate *professioinDelegate = [[DWProfessionsDelegate alloc] initWithProfessions:professions doneBlock:^(NSDictionary *profession) {
            self.text = profession[@"educationName"];
            [self.service enableAction];
        } cancelBlock:^{
            [self.service enableAction];
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"" delegate:professioinDelegate showCancelButton:YES origin:sender];
    }];
}
@end
