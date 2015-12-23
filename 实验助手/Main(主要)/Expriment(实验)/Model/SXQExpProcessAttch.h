//
//  SXQExpProcessAttch.h
//  实验助手
//
//  Created by sxq on 15/10/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQExpProcessAttch : NSObject
@property (nonatomic,copy) NSString *myExpProcessAttchID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *attchmentName;
@property (nonatomic,copy) NSString *attchmentLocation;
@property (nonatomic,assign) int isUpload;
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *attchmentServerPath;
@property (nonatomic,copy) NSString *expStepID;
@property (nonatomic,copy) NSString *imgStream;
@end
