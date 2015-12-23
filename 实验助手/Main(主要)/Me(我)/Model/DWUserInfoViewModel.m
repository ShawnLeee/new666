//
//  DWUserInfoViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/26.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetCustomPicker.h>
#import "DWZonePickerDelegate.h"
#import "DWUserInfoViewModel.h"

@implementation DWUserInfoViewModel
+ (instancetype)userInforViewModelWithTitle:(NSString *)title text:(NSString *)text idStr:(NSString *)idStr
{
    DWUserInfoViewModel *viewModel = [DWUserInfoViewModel new];
    viewModel.title = title;
    viewModel.text = text;
    viewModel.idStr = idStr;
    viewModel.shouldBeginEditing = NO;
    return viewModel;
}
+ (instancetype)userInforViewModelWithTitle:(NSString *)title text:(NSString *)text idStr:(NSString *)idStr editType:(MeEditType)type
{
    DWUserInfoViewModel *viewModel = [self userInforViewModelWithTitle:title text:text idStr:idStr];
    viewModel.type = type;
    return viewModel;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (self.type) {
        case MeEditTypeZone:
            [self showZone:textField];
            break;
            
        default:
            break;
    }
    return self.shouldBeginEditing;
}
- (void)showZone:(UITextField *)textfield
{
    DWZonePickerDelegate *zoneDelegate = [[DWZonePickerDelegate alloc] initWithDoneBlock:^(NSDictionary *province, NSDictionary *city) {
        NSString *zoneStr = [NSString stringWithFormat:@"%@  %@",province[@"name"],city[@"name"]];
        self.text = zoneStr;
        self.idDict = @{@"provinceId" : province[@"id"]? : @"",@"cityId" : city[@"id"]?:@""};
    } cancelBlock:^{
        
    }];
    [ActionSheetCustomPicker showPickerWithTitle:@"" delegate:zoneDelegate showCancelButton:YES origin:textfield];
}
@end
