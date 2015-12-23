//
//  SXQReview.h
//  实验助手
//
//  Created by sxq on 15/11/6.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQReview : NSObject
@property (nonatomic,copy) NSString *agreeCount;
@property (nonatomic,copy) NSString *disagreeCount ;
@property (nonatomic,copy) NSString *expReviewID ;
@property (nonatomic,assign) NSUInteger expScore ;
@property (nonatomic,copy) NSString *nickName ;
@property (nonatomic,copy) NSString *reviewDate ;
@end
