//
//  DWSubCategoryDelegate.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpSubCategory;
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>
typedef void (^SubDoneBlock)(SXQExpSubCategory *expSubCategory);
typedef void (^CancelBlock)();

@interface DWSubCategoryDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithDoneBlock:(SubDoneBlock)doneBlock
                      cancelBlock:(CancelBlock)cancelBlock
                       categories:(NSArray *)subCategories;
@end
