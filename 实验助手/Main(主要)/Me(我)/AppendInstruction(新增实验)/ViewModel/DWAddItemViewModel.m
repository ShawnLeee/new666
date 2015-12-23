//
//  DWAddItemViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpEquipment.h"
#import "DWAddEquipmentController.h"
#import "DWAddReagentViewModel.h"
#import "SXQNavgationController.h"
#import "DWAddReagentController.h"
#import "DWAddReagentViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddItemViewModel.h"
#import "DWItemCellViewModel.h"
#import "DWAddConsumableController.h"
#import "DWAddExpConsumable.h"
#import "DWAddExpReagent.h"
typedef void (^AddDoneBlock)(id itemModel);
@interface DWAddItemViewModel ()
@property (nonatomic,strong) id<DWAddInstructionService> service;
@end
@implementation DWAddItemViewModel
- (instancetype)initWithItemName:(NSString *)itemName
                        itemType:(DWAddItemType)itemType
                         service:(id<DWAddInstructionService>)service
                   instructionID:(NSString *)instructionID
{
    if (self = [super init]) {
        self.instructionID = instructionID;
        _itemType = itemType;
        _itemName = itemName;
        _service = service;
        _items = [NSMutableArray array];
        _itemModels = [NSMutableArray array];
        _addCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [self pushVCWithItemType:self.itemType];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}
- (instancetype)initWithItemName:(NSString *)itemName itemType:(DWAddItemType)itemType service:(id<DWAddInstructionService>)service instructionID:(NSString *)instructionID itemModels:(NSArray *)itemModels
{
    if (self = [self initWithItemName:itemName itemType:itemType service:service instructionID:instructionID]) {
        self.itemModels = [itemModels mutableCopy];
        self.items = [self p_itemsWithItemModels:itemModels];
    }
    return self;
}
- (NSMutableArray *)p_itemsWithItemModels:(NSArray *)itemModels
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    [itemModels enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL * _Nonnull stop) {
        DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:model];
        [tmpArray addObject:cellViewModel];
    }];
    return tmpArray;
    
}
- (void)pushVCWithItemType:(DWAddItemType)itemType
{
    id viewController = nil;
    switch (itemType) {
        case DWAddItemTypeReagent:
        {
            DWAddReagentController *reagentVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddReagentController class])];
            reagentVC.instrucitonID = self.instructionID;
            reagentVC.doneBlock = ^(DWAddExpReagent *addExpReagent)
            {
                [self.itemModels addObject:addExpReagent];
                
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:addExpReagent];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = reagentVC;
            break;
        }
        case DWAddItemTypeConsumable:
        {
            DWAddConsumableController *consumableVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddConsumableController class])];
            consumableVC.doneBlock = ^(DWAddExpConsumable *addExpConsumable){
                [self.itemModels addObject:addExpConsumable];
                
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:addExpConsumable];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = consumableVC;
            break;
        }
        case DWAddItemTypeEquipment:
        {
            DWAddEquipmentController *equipmentVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddEquipmentController class])];
            equipmentVC.doneBlock = ^(DWAddExpEquipment *addExpEquipment)
            {
                [self.itemModels addObject:addExpEquipment];
                
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:addExpEquipment];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = equipmentVC;
            break;
        }
    }
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:viewController];
    [self.service presentViewController:nav];
}
@end
