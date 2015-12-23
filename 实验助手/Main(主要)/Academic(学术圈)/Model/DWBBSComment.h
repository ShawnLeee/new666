//
//  DWBBSComment.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWBBSComment : NSObject
@property (nonatomic,copy) NSString *reviewDateTime;
@property (nonatomic,copy) NSString *reviewer;
@property (nonatomic,copy) NSString *reviewID;
@property (nonatomic,copy) NSString *reviewDetail;
@property (nonatomic,copy) NSString *parentReviewID;
@property (nonatomic,copy) NSString *parentReviewer;
@end
