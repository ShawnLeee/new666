//
//  DWMyExpAttach.h
//  实验助手
//
//  Created by sxq on 16/1/8.
//  Copyright © 2016年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWMyExpAttach : NSObject
@property (nonatomic,copy) NSString *myExpAttchID;
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *attchmentName;
@property (nonatomic,copy) NSString *attchLocation;
@property (nonatomic,copy) NSString *attchmentServerPath;
@property (nonatomic,assign) int isUpload;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSString *imgStream;
@end
