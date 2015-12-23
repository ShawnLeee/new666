//
//  DWCommentGroup.h
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWCommentGroup : NSObject
@property (nonatomic,copy) NSString *expReviewOptID;
@property (nonatomic,copy) NSString *expReviewOptName;
@property (nonatomic,strong) NSArray *expReviewDetailOfOpts;
@property (nonatomic,assign) NSInteger expReviewOptScore;
@end
