//
//  SXQExpInstruction.h
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQExpInstruction : NSObject
@property (nonatomic,assign) int  allowDownload;
@property (nonatomic,copy) NSString * createDate;
@property (nonatomic,assign) int downloadCount;
@property (nonatomic,copy) NSString * expCategoryID;
@property (nonatomic,copy) NSString * expSubCategoryID;
@property (nonatomic,copy) NSString * experimentDesc;
@property (nonatomic,copy) NSString * experimentName;
@property (nonatomic,copy) NSString * experimentTheory;
@property (nonatomic,copy) NSString * expInstructionID;
@property (nonatomic,copy) NSString * filterStr;
@property (nonatomic,copy) NSString * productNum;
@property (nonatomic,copy) NSString * provideUser;
@property (nonatomic,assign) int reviewCount;
@property (nonatomic,copy) NSString * supplierID;
@property (nonatomic,copy) NSString * supplierName;
@property (nonatomic,assign) int  expVersion;

@property (nonatomic,assign,getter=isDownloaded) BOOL downloaded;
@property (nonatomic,assign) int localized;
@property (nonatomic,copy) NSString *expCategoryName;
@property (nonatomic,copy) NSString *expSubCategoryName;
@end
