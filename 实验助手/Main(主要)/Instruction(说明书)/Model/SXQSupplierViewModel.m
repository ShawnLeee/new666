//
//  SXQSupplierViewModel.m
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpReagent.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"
#import "SXQSupplierViewModel.h"
#import "SXQSupplier.h"
@implementation SXQSupplierViewModel
- (instancetype)initWithModel:(id)model
{
    if (self = [super init]) {
        if ([model isKindOfClass:[SXQExpReagent class]]) {
            self.reagentModel = model;
        }else if([model isKindOfClass:[SXQExpConsumable class]])
        {
            self.consumableModel = model;
        }else if([model isKindOfClass:[SXQExpEquipment class]])
        {
            self.equipmentModel = model;
        }
        [self setupChooseCommand];
    }
    return self;
    
}
- (void)setupChooseCommand
{
    _chooseSupplierCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[self.service showSuppliersPickerWithSuppliers:self.suppliers sender:input]
             subscribeNext:^(SXQSupplier *supplier) {
                 if (supplier) {
                     self.supplier = supplier;
                 }
                 [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}
- (void)setReagentModel:(SXQExpReagent *)reagentModel
{
    _reagentModel = reagentModel;
    
    self.supplier = reagentModel.supplier;
    self.itemName = reagentModel.reagentName;
    self.suppliers = reagentModel.suppliers;
    
    [RACObserve(self, supplier)
     subscribeNext:^(SXQSupplier *supplier) {
         self.reagentModel.supplier = supplier;
    }];
}
- (void)setConsumableModel:(SXQExpConsumable *)consumableModel
{
    _consumableModel = consumableModel;
    
    self.supplier = consumableModel.supplier;
    self.itemName = consumableModel.consumableName;
    self.suppliers = consumableModel.suppliers;
    
    [RACObserve(self, supplier)
     subscribeNext:^(SXQSupplier *supplier) {
         self.consumableModel.supplier = supplier;
     }];
}
- (void)setEquipmentModel:(SXQExpEquipment *)equipmentModel
{
    _equipmentModel = equipmentModel;
    self.itemName = equipmentModel.equipmentName;
    self.supplier = equipmentModel.supplier;
    self.suppliers = equipmentModel.suppliers;
    
    [RACObserve(self, supplier)
     subscribeNext:^(SXQSupplier *supplier) {
         self.equipmentModel.supplier = supplier;
     }];
}
- (void)setSupplier:(SXQSupplier *)supplier
{
    _supplier = supplier;
}
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"-----------------------------------\n<%@: %p> %@\n-----------------------------------",self.class,self,@{@"supplier" : self.supplier? :@"nil",@"suppliers" : self.suppliers}];
}
@end
