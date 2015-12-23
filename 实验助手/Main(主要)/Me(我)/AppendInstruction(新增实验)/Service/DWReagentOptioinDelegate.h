//
//  DWReagentOptioinDelegate.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>

@interface DWReagentOptioinDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithReagentOptions:(NSArray *)reagentOptions
                             doneBlock:(void (^)(id result))doneBlock;
@end
