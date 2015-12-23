//
//  DWInstructionDetailController.h
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction,SXQInstructionDetail;
#import <UIKit/UIKit.h>

@interface DWInstructionDetailController : UICollectionViewController
@property (nonatomic,strong) SXQExpInstruction *instruction;
@property (nonatomic,strong) SXQInstructionDetail *instructionDetail;
@property (nonatomic,strong) NSArray *groups;
@end
