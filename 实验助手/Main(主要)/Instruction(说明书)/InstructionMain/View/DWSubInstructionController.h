//
//  DWSubInstructionController.h
//  实验助手
//
//  Created by sxq on 15/11/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpCategoryViewModel;
#import "SXQInstructionService.h"
#import <UIKit/UIKit.h>

@interface DWSubInstructionController : UICollectionViewController
@property (nonatomic,strong) SXQExpCategoryViewModel *viewModel;
@property (nonatomic,strong) id<SXQInstructionService> service;
@end
