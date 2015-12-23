//
//  DWReagentOption.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWReagentOption : NSObject
@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,copy) NSString *reagentName;
+ (instancetype)reagentOption;
@end
