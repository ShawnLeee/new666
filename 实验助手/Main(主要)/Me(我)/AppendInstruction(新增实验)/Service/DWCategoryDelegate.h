//
//  DWCategoryDelegate.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpCategory;
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>
typedef void (^DoneBlock)(SXQExpCategory *expCategory);
typedef void (^CancelBlock)();
@interface DWCategoryDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithDoneBlock:(DoneBlock)doneBlock
                      cancelBlock:(CancelBlock)cancelBlock
                       categories:(NSArray *)catetories;
@end
