//
//  DWSupplierDelegate.h
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>
typedef void (^DoneBlock)(SXQSupplier *supplier);
typedef void (^CancelBlock)();
@interface DWSupplierDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithSuppliers:(NSArray *)suppliers
                        doneBlock:(DoneBlock)doneBlock
                      cancelBlock:(CancelBlock)cancelBlock;
@end
