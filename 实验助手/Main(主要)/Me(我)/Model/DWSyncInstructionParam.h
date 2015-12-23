//
//  DWSyncInstructionParam.h
//  实验助手
//
//  Created by sxq on 15/12/18.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQBaseParam.h"
@interface DWSyncInstructionParam : SXQBaseParam
@property (nonatomic,strong) NSString *json;
@property (nonatomic,assign) int allowDownload;
@end
