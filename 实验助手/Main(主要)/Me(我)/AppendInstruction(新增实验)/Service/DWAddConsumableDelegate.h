//
//  DWAddConsumableDelegate.h
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>

@interface DWAddConsumableDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithConsumables:(NSArray *)consumables doneBlock:(void (^)(id result))doneBlock;
@end
