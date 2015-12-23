//
//  SXQInstructionDetail.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SXQInstructionDetail : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *experimentDesc;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,copy) NSString *experimentTheory;
@property (nonatomic,copy) NSString *instructState;
@property (nonatomic,copy) NSString *productNum;
@property (nonatomic,copy) NSString *supplierName;

@property (nonatomic,strong) NSArray *expConsumables;
@property (nonatomic,strong) NSArray *steps;
@property (nonatomic,strong) NSArray *expReagents;
@property (nonatomic,strong) NSArray *expEquipments;
@property (nonatomic,strong) NSArray *reviews;

@property (nonatomic,assign) BOOL stepSaved;
@property (nonatomic,assign) BOOL consumableSaved;
@property (nonatomic,assign) BOOL reagentsSaved;
@property (nonatomic,assign) BOOL equipmentsSaved;
@end
