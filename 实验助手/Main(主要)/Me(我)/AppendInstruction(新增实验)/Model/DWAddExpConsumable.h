//
//  DWAddExpConsumable.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAddExpConsumable : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *expConsumableID;
@property (nonatomic,copy) NSString *consumableID;
@property (nonatomic,copy) NSString *consumableName;
@property (nonatomic,assign) int consumableCount;

@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *consumableType;
@property (nonatomic,copy) NSString *consumableFactory;
@property (nonatomic,strong) NSArray *suppliers;
@end
