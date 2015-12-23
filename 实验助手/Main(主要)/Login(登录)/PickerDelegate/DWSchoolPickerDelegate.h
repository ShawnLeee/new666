//
//  DWSchoolPickerDelegate.h
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>
typedef void (^SchoolDoneBlock)(NSDictionary *school);
typedef void (^CancelBlock)();
@interface DWSchoolPickerDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithSchools:(NSArray *)schools doneBlock:(SchoolDoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock;
@end
