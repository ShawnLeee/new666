//
//  DWAddExpInstruction.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAddExpInstruction : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,copy) NSString *experimentDesc;
@property (nonatomic,copy) NSString *experimentTheory;
@property (nonatomic,copy) NSString *provideUser;
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,copy) NSString *productNun;
@property (nonatomic,copy) NSString *expCategoryID;
@property (nonatomic,copy) NSString *expSubCategoryID;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *expSubCategoryName;
@property (nonatomic,copy) NSString *expCategoryName;
/**
 *  0-不允许下载，1-允许下载，2 share
 */
@property (nonatomic,assign) int allowDownload;
@property (nonatomic,assign) int expVersion;
+ (instancetype)expInstruction;
@end
