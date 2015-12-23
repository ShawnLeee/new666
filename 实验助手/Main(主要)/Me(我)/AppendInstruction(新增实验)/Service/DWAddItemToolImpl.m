//
//  DWAddItemToolImpl.m
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddEquipmentDelegate.h"
#import "DWAddConsumableDelegate.h"

#import "DWAddExpEquipment.h"
#import "DWAddExpConsumable.h"
#import "DWAddExpReagent.h"

#import "SXQSupplier.h"
#import "DWReagentOption.h"
#import "DWReagentSecondClarify.h"
#import "DWReagentFirstClarify.h"
#import "SXQHttpTool.h"
#import "DWReagentFirstDelegate.h"
#import <ActionSheetCustomPicker.h>
#import "DWAddItemToolImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJExtension/MJExtension.h>
#import "DWReagentSecondDelegate.h"
#import "DWReagentOptioinDelegate.h"
#import "DWAddSupplierDelegate.h"
@implementation DWAddItemToolImpl
- (void)showFirstPickerWithOrigin:(id)origin handler:(CompletionHandler)handler
{
    [[self firstClarifySignal]
     subscribeNext:^(NSArray *firstClarifies) {
        DWReagentFirstDelegate *firstDelegate = [[DWReagentFirstDelegate alloc] initWithFirstClarifies:firstClarifies doneBlock:^(id result) {
            handler(result);
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"选择一级分类" delegate:firstDelegate showCancelButton:YES origin:origin];    
    }];
    
}
- (void)showSecondPickerWithOrigin:(id)origin levelOne:(NSString *)levelOneID handler:(CompletionHandler)handler
{
    
    [[self secondClarifySignalWithLevelOneID:levelOneID]
    subscribeNext:^(NSArray *secondClarifies) {
        DWReagentSecondDelegate *secondDelegate = [[DWReagentSecondDelegate alloc] initWithSecondClarifies:secondClarifies doneBlock:^(DWReagentSecondClarify *secondClarify) {
            handler(secondClarify);
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"选择二级分类" delegate:secondDelegate showCancelButton:YES origin:origin];
    }];
}
- (void)showReagentWithOrigin:(id)origin levelOne:(NSString *)levelOneID levelTwo:(NSString *)levelTwoID handler:(CompletionHandler)handler
{
    [[self reagentNamesSignalWithLevelOneID:levelOneID levelTwoID:levelTwoID]
    subscribeNext:^(NSArray *reagentOptions) {
        DWReagentOptioinDelegate *reagentOptionDelegate = [[DWReagentOptioinDelegate alloc] initWithReagentOptions:reagentOptions doneBlock:^(id result) {
            handler(result);
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"选择试剂" delegate:reagentOptionDelegate showCancelButton:YES origin:origin];
    }];
}
- (void)showSupplierWithOrigin:(id)origin itemType:(DWAddItemType)itemType itemID:(NSString *)itemID handler:(CompletionHandler)handler
{
    [[self suppliersSignalWithItemType:itemType itemID:itemID]
    subscribeNext:^(NSArray *suppliers) {
        DWAddSupplierDelegate *delegate = [[DWAddSupplierDelegate alloc] initWithSuppliers:suppliers doneBlock:^(id result) {
            handler(result);
        }];
        [ActionSheetCustomPicker showPickerWithTitle:@"选择供应商" delegate:delegate showCancelButton:YES origin:origin];
    }];
    
}
- (RACSignal *)firstClarifySignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ReagentFirstClarifyURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray<DWReagentFirstClarify *> *firstClarifies = [DWReagentFirstClarify mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:firstClarifies];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)secondClarifySignalWithLevelOneID:(NSString *)levelOneID
{
    NSDictionary *param = @{@"levelOneID" : levelOneID? : @""};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ReagentSecondClarifyURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *secondClarifies = [DWReagentSecondClarify mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:secondClarifies];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)reagentNamesSignalWithLevelOneID:(NSString *)levelOneID levelTwoID:(NSString *)levelTwoID
{
    NSDictionary *param = @{@"levelOneID" : levelOneID ,@"evelTwoID" : levelTwoID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:GetReagentURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *reagentOptions = [DWReagentOption mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:reagentOptions];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)suppliersSignalWithItemType:(DWAddItemType)itemType itemID:(NSString *)itemID
{
    NSDictionary *param = @{@"mark" : @(itemType),@"id" : itemID ? : @""};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:GetSupplierURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *suppliers = [SXQSupplier mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:suppliers];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)searchItemSignalWithName:(NSString *)name itemType:(DWAddItemType)itemType
{
    NSDictionary *param = @{@"name" : name? : @"",@"mark" : @(itemType)};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SearchItemURL params:param success:^(id json) {
            NSArray *itemsArray = @[];
            if ([json[@"code"] isEqualToString:@"1"]) {
                switch (itemType) {
                case DWAddItemTypeReagent:
                {
                    itemsArray = [DWAddExpReagent mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    break;
                }
                case DWAddItemTypeConsumable:
                {
                    itemsArray = [DWAddExpConsumable mj_objectArrayWithKeyValuesArray: json[@"data"]];
                    break;
                }
                case DWAddItemTypeEquipment:
                {
                    itemsArray = [DWAddExpEquipment mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    break;
                }
            }
                
        }
       [subscriber sendNext:itemsArray];
       [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)fetchConsumablesSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:FetchAddConsumabelsURL params:nil success:^(id json) {
            NSArray *equipments = @[];
            if ([json[@"code"] isEqualToString:@"1"]) {
                equipments = [DWAddExpConsumable mj_objectArrayWithKeyValuesArray:json[@"data"]];
            }
            [subscriber sendNext:equipments];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (void)showConsumablePickerWithConsumables:(NSArray *)consumables origin:(id)origin handler:(CompletionHandler)handler
{
    DWAddConsumableDelegate *consumableDelegate = [[DWAddConsumableDelegate alloc] initWithConsumables:consumables doneBlock:handler];
    [ActionSheetCustomPicker showPickerWithTitle:@"选择耗材" delegate:consumableDelegate showCancelButton:YES origin:origin];
}
- (RACSignal *)fetchEqupmentsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:FetchAddEquipmentsURL params:nil success:^(id json) {
            NSArray *consumables = @[];
            if ([json[@"code"] isEqualToString:@"1"]) {
                consumables = [DWAddExpEquipment mj_objectArrayWithKeyValuesArray:json[@"data"]];
            }
            [subscriber sendNext:consumables];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (void)showEquipmentPickerWithEquipments:(NSArray *)equipments origin:(id)origin handler:(CompletionHandler)handler
{
    DWAddEquipmentDelegate *equipmentDelegate = [[DWAddEquipmentDelegate alloc] initWithEquipments:equipments doneBlock:handler];
    [ActionSheetCustomPicker showPickerWithTitle:@"选择设备" delegate:equipmentDelegate showCancelButton:YES origin:origin];
}
@end


















