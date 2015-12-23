//
//  DWAddItemViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand,DWAddInstructionViewModel;
#import "DWAddInstructionService.h"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,DWAddItemType)
{
    DWAddItemTypeReagent = 0,
    DWAddItemTypeConsumable,
    DWAddItemTypeEquipment,
};

@interface DWAddItemViewModel : NSObject
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *itemModels;
@property (nonatomic,strong) RACCommand *addCommand;
@property (nonatomic,assign) DWAddItemType itemType;
@property (nonatomic,copy) NSString *instructionID;

- (instancetype)initWithItemName:(NSString *)itemName
                        itemType:(DWAddItemType)itemType
                         service:(id<DWAddInstructionService>)service
                   instructionID:(NSString *)instructionID;

- (instancetype)initWithItemName:(NSString *)itemName
                        itemType:(DWAddItemType)itemType
                         service:(id<DWAddInstructionService>)service
                   instructionID:(NSString *)instructionID
                           itemModels:(NSArray *)itemModels;
@end
