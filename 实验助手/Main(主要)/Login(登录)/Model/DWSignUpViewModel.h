//
//  DWSignUpViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWSignUpServiceImpl;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,SignUpFieldType){
    SignUpFieldTypeInput = 0,
    SignUpFieldTypeZone = 1,//地区
    SignUpFieldTypeSchool = 2,//学校
    SignUpFieldTypeProfession = 3,//专业
    SignUpFieldTypeDegree = 4,//学历
    SignUpFieldTypeIdentity = 5,//职称
    SignUpFieldTypeUserName = 6,
    SignUpFieldTypeEmail = 7,
    SignUpFieldTypePassword = 8,
    SignUpFieldTypeRePassWord = 9,
};
@interface DWSignUpViewModel : NSObject<UITextFieldDelegate>
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) BOOL shouldBeginEditing;
@property (nonatomic,assign) SignUpFieldType fieldType;
@property (nonatomic,weak) DWSignUpServiceImpl *service;
//@property (nonatomic,weak) UITableViewCell *cell;
@end
