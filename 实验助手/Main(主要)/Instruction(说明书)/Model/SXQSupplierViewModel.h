//
//  SXQSupplierViewModel.h
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWMyExperimentServices.h"
@class SXQExpConsumable,SXQExpReagent,SXQExpEquipment,SXQSupplier,RACCommand;
#import <Foundation/Foundation.h>

@interface SXQSupplierViewModel : NSObject
@property (nonatomic,strong) id<DWMyExperimentServices> service;
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,strong) SXQSupplier *supplier;
@property (nonatomic,strong) NSArray *suppliers;
@property (nonatomic,strong) SXQExpReagent *reagentModel;
@property (nonatomic,strong) SXQExpEquipment *equipmentModel;
@property (nonatomic,strong) SXQExpConsumable *consumableModel;
@property (nonatomic,strong) RACCommand *chooseSupplierCommand;
- (instancetype)initWithModel:(id)model;
@end
