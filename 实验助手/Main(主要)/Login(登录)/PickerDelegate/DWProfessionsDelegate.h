//
//  DWProfessionsDelegate.h
//  实验助手
//
//  Created by sxq on 15/11/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <ActionSheetCustomPickerDelegate.h>
#import <Foundation/Foundation.h>

@interface DWProfessionsDelegate : NSObject<ActionSheetCustomPickerDelegate>
- (instancetype)initWithProfessions:(NSArray *)professions
                          doneBlock:(void (^)(NSDictionary *profession))doneBlock
                        cancelBlock:(void (^)())cancelBcock;
@end
