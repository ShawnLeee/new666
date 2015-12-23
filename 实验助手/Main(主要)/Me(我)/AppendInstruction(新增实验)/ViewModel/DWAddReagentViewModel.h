//
//  DWAddReagentViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//

@class DWAddExpReagent;
#import <Foundation/Foundation.h>

@interface DWAddReagentViewModel : NSObject

@property (nonatomic,copy) NSString *firstClass;
@property (nonatomic,copy) NSString *firstID;

@property (nonatomic,copy) NSString *secondClass;
@property (nonatomic,copy) NSString *secondID;

@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *reagentID;

@property (nonatomic,assign) int amount;

@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *supplierID;

@property (nonatomic,strong) DWAddExpReagent *expReagent;
- (instancetype)initWithAddExpReagent:(DWAddExpReagent *)addExpReagent;
@end
