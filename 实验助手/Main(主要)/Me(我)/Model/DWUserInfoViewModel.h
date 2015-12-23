//
//  DWUserInfoViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/26.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,MeEditType){
    MeEditTypeUserName = 0,//姓名
    MeEditTypeSchool ,//学校
    MeEditTypeProfession ,//专业
    MeEditTypeDegree  ,//学历
    MeEditTypeIdentity ,//职称
    MeEditTypeTelNum ,
    MeEditTypeEmail ,
    MeEditTypeZone ,
};
@interface DWUserInfoViewModel : NSObject<UITextFieldDelegate>
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,strong) NSDictionary *idDict;
@property (nonatomic,assign) BOOL shouldBeginEditing;
@property (nonatomic,assign) MeEditType type;
+ (instancetype)userInforViewModelWithTitle:(NSString *)title text:(NSString *)text idStr:(NSString *)idStr;
+ (instancetype)userInforViewModelWithTitle:(NSString *)title text:(NSString *)text idStr:(NSString *)idStr editType:(MeEditType)type;
@end
