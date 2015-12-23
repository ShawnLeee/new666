//
//  DWZonePickerDelegate.h
//  实验助手
//
//  Created by SXQ on 15/11/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>
typedef void (^DoneBlock)(NSDictionary *province,NSDictionary *city);
typedef void (^CancelBlock)();
@interface DWZonePickerDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithDoneBlock:(DoneBlock)doneBlock cancelBlock:(CancelBlock)cancelBlock;
@end
