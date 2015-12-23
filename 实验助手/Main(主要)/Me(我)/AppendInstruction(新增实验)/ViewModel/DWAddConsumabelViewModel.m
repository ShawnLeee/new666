//
//  DWAddConsumabelViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "DWAddExpConsumable.h"
#import "DWAddConsumabelViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation DWAddConsumabelViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.addExpConsumable = [[DWAddExpConsumable alloc] init];
    }
    return self;
}
- (instancetype)initWithExpConsumabel:(DWAddExpConsumable *)addExpConsumable
{
    if (self = [super init]) {
        self.addExpConsumable = addExpConsumable;
    }
    return self;
}
- (void)setAddExpConsumable:(DWAddExpConsumable *)addExpConsumable
{
    _addExpConsumable = addExpConsumable;
    self.consumableName = addExpConsumable.consumableName;
    self.consumableID = addExpConsumable.consumableID;
    self.amout = addExpConsumable.consumableCount;
    if (addExpConsumable.suppliers.count) {
        self.supplierName = [[[addExpConsumable suppliers] firstObject] supplierName];
        self.supplierID = [[[addExpConsumable suppliers] firstObject] supplierID];
    }else
    {
        self.supplierID = addExpConsumable.supplierID;
        self.supplierName = addExpConsumable.supplierName;
    }
    
    [self p_bindingModel];
}
- (void)p_bindingModel
{
    RAC(self.addExpConsumable,consumableName) = RACObserve(self,consumableName);
    RAC(self.addExpConsumable,consumableID) = RACObserve(self, consumableID);
    RAC(self.addExpConsumable,supplierName) = RACObserve(self, supplierName);
    RAC(self.addExpConsumable,supplierID)  = RACObserve(self, supplierID);
    RAC(self.addExpConsumable,consumableCount) = RACObserve(self, amout);
}
@end
