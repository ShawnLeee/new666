//
//  DWCommentItem.h
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWCommentItem : NSObject
@property (nonatomic,copy) NSString *itemID;
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,assign) int itemScore;
@end
