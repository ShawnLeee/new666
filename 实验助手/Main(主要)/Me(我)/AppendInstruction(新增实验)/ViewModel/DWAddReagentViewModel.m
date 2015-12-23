//
//  DWAddReagentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "DWAddExpReagent.h"
#import "DWAddReagentViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddItemToolImpl.h"
@interface DWAddReagentViewModel ()
@end
@implementation DWAddReagentViewModel
- (instancetype)initWithAddExpReagent:(DWAddExpReagent *)addExpReagent
{
    if (self = [super init]) {
        self.expReagent = addExpReagent;
    }
    return self;
}
- (void)setExpReagent:(DWAddExpReagent *)expReagent
{
    _expReagent = expReagent;
    _firstClass = expReagent.levelOneSortName;
    _firstID = expReagent.levelTwoSortID;
    
    _secondClass = expReagent.levelTwoSortName;
    _secondID = expReagent.levelTwoSortID;
    
    _reagentName = expReagent.reagentName;
    _reagentID = expReagent.reagentID;
    
    _amount = expReagent.useAmount;
    
    _supplierName = expReagent.supplierName;
    _supplierID = expReagent.supplierID;
    
    [self bingModel];
}
- (void)bingModel
{
    RAC(self.expReagent,levelOneSortID) = RACObserve(self, firstID);
    RAC(self.expReagent,levelOneSortName) = RACObserve(self, firstClass);
    
    RAC(self.expReagent,levelTwoSortID) = RACObserve(self, secondID);
    RAC(self.expReagent,levelTwoSortName) = RACObserve(self, secondClass);
    
    RAC(self.expReagent,reagentName) = RACObserve(self, reagentName);
    RAC(self.expReagent,reagentID) = RACObserve(self, reagentID);
    
    RAC(self.expReagent,useAmount) = RACObserve(self, amount);
    
    RAC(self.expReagent,supplierName) = RACObserve(self, supplierName);
    RAC(self.expReagent,supplierID) = RACObserve(self, supplierID);
}
@end
