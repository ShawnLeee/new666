//
//  DWReagentExchangeTool.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,SXQAdjacentUserParam;
#import <Foundation/Foundation.h>

@protocol DWReagentExchangeTool <NSObject>
- (RACSignal *)adjacentUserSignalWith:(SXQAdjacentUserParam *)param;
- (RACSignal *)setReagentWithReagentName:(NSString *)reagentName;
@end
