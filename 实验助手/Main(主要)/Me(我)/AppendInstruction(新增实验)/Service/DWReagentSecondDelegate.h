//
//  DWReagentSecondDelegate.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>

@interface DWReagentSecondDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithSecondClarifies:(NSArray *)secondClarifies
                              doneBlock:(void (^)(id result))doneBlock;
@end
