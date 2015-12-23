//
//  DWInstructionNavViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,InstructionDetaiVcType) {
    InstructionDetaiVcTypeComment = 0,
    InstructionDetaiVcTypeSteps,
    InstructionDetaiVcTypeText,
};

@interface DWInstructionNavViewModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *vcTitle;
/**
 *  跳转的控制器
 */
@property (nonatomic,assign) InstructionDetaiVcType vcType;
@property (nonatomic,copy) NSArray *items;
@end
