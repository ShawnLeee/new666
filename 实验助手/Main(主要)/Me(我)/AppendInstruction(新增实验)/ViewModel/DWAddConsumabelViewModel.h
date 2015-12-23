//
//  DWAddConsumabelViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpConsumable;
#import <Foundation/Foundation.h>

@interface DWAddConsumabelViewModel : NSObject
@property (nonatomic,copy) NSString *consumableName;
@property (nonatomic,copy) NSString *consumableID;
@property (nonatomic,assign) int amout;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *supplierID;

@property (nonatomic,strong) DWAddExpConsumable *addExpConsumable;
- (instancetype)initWithExpConsumabel:(DWAddExpConsumable *)addExpConsumable;
@end
