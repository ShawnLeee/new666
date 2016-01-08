//
//  DGConclusionViewModel.h
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//
@class RACCommand,UITableViewCell;
#import <Foundation/Foundation.h>
#import "SXQExperimentServices.h"
@interface DGConclusionViewModel : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *conclusionText;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) RACCommand *addImageCmd;
@property (nonatomic,weak) UITableViewCell *cell;
@property (nonatomic,copy) void (^updateUIBlock)();
- (instancetype)initWithService:(id<SXQExperimentServices>)service;

@end
