//
//  DWItemCellViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWItemCellViewModel : NSObject
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,strong) id model;
- (instancetype)initWithModel:(id)model;
@end
