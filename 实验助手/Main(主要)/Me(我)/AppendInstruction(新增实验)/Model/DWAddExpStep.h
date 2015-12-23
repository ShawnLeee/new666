//
//  DWAddExpStep.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAddExpStep : NSObject
@property (nonatomic,copy) NSString *expStepID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,assign) NSUInteger stepNum;
@property (nonatomic,copy) NSString *expStepDesc;
@property (nonatomic,assign) NSUInteger expStepTime;

- (instancetype)initWithInstructionID:(NSString *)instructionID;
@end
