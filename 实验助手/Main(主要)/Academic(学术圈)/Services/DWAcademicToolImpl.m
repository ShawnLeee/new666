//
//  DWAcademicToolImpl.m
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQURL.h"
#import "DWNews.h"
#import "SXQHttpTool.h"
#import "DWAcademicToolImpl.h"

@implementation DWAcademicToolImpl
- (RACSignal *)newsSignal
{
    return [self newsArraySignal];
}
- (RACSignal *)newsArraySignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:NewsURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *newsArray = [DWNews objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:newsArray];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
            }
                
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
