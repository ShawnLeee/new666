//
//  SXQReprotItem.h
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQReportItem : NSObject
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *pdfName;
@property (nonatomic,assign) BOOL downloaded;
@end
