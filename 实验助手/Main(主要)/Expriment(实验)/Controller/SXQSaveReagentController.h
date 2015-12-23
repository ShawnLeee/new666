//
//  SXQSaveReagentController.h
//  实验助手
//
//  Created by sxq on 15/9/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class CellContainerViewModel;
#import <UIKit/UIKit.h>

@interface SXQSaveReagentController : UIViewController
- (instancetype)initWithViewModel:(CellContainerViewModel *)viewModel completion:(void (^)())completion;
@end
