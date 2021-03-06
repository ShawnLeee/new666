//
//  DWMeServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]
#import "DWGroup.h"
#import "DWUserIcon.h"
#import "NSString+Base64.h"
#import "NSString+JSON.h"
#import "DWSyncInstructionParam.h"
#import "DWLoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "SXQBaseParam.h"
#import "Account.h"
#import "DWUserInfoViewModel.h"
#import "AccountTool.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeServiceImpl.h"
#import "DWMeItem.h"
#import <MJExtension/MJExtension.h>
#import "SXQDBManager.h"
#import "SXQExpInstruction.h"
#import "SXQHttpTool.h"
#import "DWInstructionUploadParam.h"
#import "DWMeEditParam.h"

@interface DWMeServiceImpl()
@property (nonatomic,strong) DWMeEditParam *editParam;
@end
@implementation DWMeServiceImpl
- (DWMeEditParam *)editParam
{
    if (!_editParam) {
        _editParam = [[DWMeEditParam alloc] init];
    }
    return _editParam;
}
- (RACSignal *)userInfoSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *userID = [[AccountTool account] userID] ? :@"";
        NSDictionary *param = @{@"userID" : userID};
        [SXQHttpTool getWithURL:UserInfoURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                 NSArray *viewModels = [self userInfoViewModelWithDict:json[@"data"]];
                [subscriber sendNext:viewModels];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
           
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (NSArray *)userInfoViewModelWithDict:(NSDictionary *)dict
{

    @weakify(self)
    
    DWUserInfoViewModel *userName = [DWUserInfoViewModel userInforViewModelWithTitle:@"用户名" text:nilOrJSONObjectForKey(dict, @"nickName") idStr:nil editType:MeEditTypeUserName];
    
    DWUserInfoViewModel *email = [DWUserInfoViewModel userInforViewModelWithTitle:@"邮箱" text:nilOrJSONObjectForKey(dict, @"email") idStr:nil editType:MeEditTypeEmail];
    email.shouldBeginEditing = YES;
    RAC(self.editParam,eMail) = RACObserve(email, text);
    
    NSDictionary *majorDict = nilOrJSONObjectForKey(dict, @"major");
    NSString *majorName = nilOrJSONObjectForKey(majorDict, @"majorName");
    DWUserInfoViewModel *major = [DWUserInfoViewModel userInforViewModelWithTitle:@"专业" text:majorName idStr:nil editType:MeEditTypeProfession];
    RAC(self.editParam,majorID) = RACObserve(major, idStr);
    
    NSDictionary *eduDict = nilOrJSONObjectForKey(dict, @"education");
    NSString *educationName = nilOrJSONObjectForKey(eduDict, @"educationName");
    DWUserInfoViewModel *degree = [DWUserInfoViewModel userInforViewModelWithTitle:@"学历" text:educationName idStr:nil editType:MeEditTypeDegree];
    RAC(self.editParam,educationID) = RACObserve(degree, idStr);
    
    NSDictionary *titleDict = nilOrJSONObjectForKey(dict, @"title");
    NSString *titleName = nilOrJSONObjectForKey(titleDict, @"titleName");
    DWUserInfoViewModel *identity = [DWUserInfoViewModel userInforViewModelWithTitle:@"职称" text:titleName idStr:nil editType:MeEditTypeIdentity];
    
    NSDictionary *collegeDict = nilOrJSONObjectForKey(dict, @"college");
    NSString *colleageName = nilOrJSONObjectForKey(collegeDict, @"collegeName");
    DWUserInfoViewModel *college = [DWUserInfoViewModel userInforViewModelWithTitle:@"学校" text:colleageName idStr:nil editType:MeEditTypeSchool];
    RAC(self.editParam,collegeID) = RACObserve(college, idStr);
    
    DWUserInfoViewModel *telNumber = [DWUserInfoViewModel userInforViewModelWithTitle:@"电话" text:nilOrJSONObjectForKey(dict, @"telNo") idStr:nil editType:MeEditTypeTelNum];
    RAC(self.editParam,telNo) = RACObserve(telNumber, text);
    telNumber.shouldBeginEditing = YES;
//    NSString *province = [dict[@"province"] isEqualToString:@""]?dict[@"province"][@"provinceName"]:nil;
//    NSString *city = [dict[@"city"] isEqualToString:@""]?dict[@"city"][@"cityName"]:nil;
//    NSString *zoneStr = [NSString stringWithFormat:@"%@  %@",province,city];
    DWUserInfoViewModel *zone = [DWUserInfoViewModel userInforViewModelWithTitle:@"地区" text:nil idStr:nil editType:MeEditTypeZone];
    [RACObserve(zone, idDict)
     subscribeNext:^(NSDictionary *idDict) {
         @strongify(self)
         self.editParam.provinceID =[NSString stringWithFormat:@"%@",idDict[@"provinceId"]];
         self.editParam.cityID = [NSString stringWithFormat:@"%@",idDict[@"cityId"]];
    }];
    
    return @[userName,email,major,degree,identity,college,telNumber,zone];
}
- (RACSignal *)meItemsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil];
        NSArray *items = [DWMeItem objectArrayWithFile:filePath];
        [subscriber sendNext:items];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)allInstructionsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSArray *dictArr = [[SXQDBManager sharedManager] meAllInstructions];
        NSArray *groups = [self groupWithDictArr:dictArr];
        [subscriber sendNext:groups];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (NSArray *)groupWithDictArr:(NSArray *)dictArr
{
    DWGroup *group0 = [DWGroup new];
    group0.items = [SXQExpInstruction mj_objectArrayWithKeyValuesArray:[dictArr firstObject]];
    group0.headerTitle = @"我创建的";
    
    DWGroup *group1 = [DWGroup new];
    group1.items = [SXQExpInstruction mj_objectArrayWithKeyValuesArray:[dictArr lastObject]];
    group1.headerTitle = @"已下载的";
    return @[group0,group1];
}
- (RACSignal *)uploadUserProfile
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:EditUserInfoURL params:self.editParam.keyValues success:^(id json) {
            if (![json[@"code"] isEqualToString:@"1"]) {
                [MBProgressHUD showError:json[@"msg"]];
            }
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (void)signOut
{
    BOOL success = [AccountTool deleteAccount];
    if (success) {
        DWLoginViewController *loginVc = [[DWLoginViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVc;
    }else
    {
        [MBProgressHUD showError:@"注销失败"];
    }
}
- (RACSignal *)uploadInstructionWithInstrucitonID:(NSString *)instructionID allowDownload:(int)allowDownload
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[self uploadParamSignalWithInstrucitonID:instructionID allowDownload:allowDownload]
        subscribeNext:^(DWSyncInstructionParam *param) {
            [SXQHttpTool postWithURL:SyncInstructionURL params:param.mj_keyValues success:^(id json) {
                BOOL success = [json[@"code"] isEqualToString:@"1"];
                if(success)
                {
                    //设置上传时间
                    [[SXQDBManager sharedManager] updateUploadTimeWithInstructionID:instructionID];
                }
                [subscriber sendNext:@(success)];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                
            }];
        }];
        return nil;
    }];
}
- (RACSignal *)uploadParamSignalWithInstrucitonID:(NSString *)instructionID allowDownload:(int)allowDownload
{
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        DWInstructionUploadParam *uploadParam = [[SXQDBManager sharedManager] getInstructionUploadDataWithInstructionID:instructionID];
        DWSyncInstructionParam *syncParam = [[DWSyncInstructionParam alloc] init];
        syncParam.json= [NSString jsonStrWithDictionary:uploadParam.mj_keyValues];
        syncParam.allowDownload = allowDownload;
        
        [subscriber sendNext:syncParam];
        [subscriber sendCompleted];
        return nil;
    }] deliverOn:scheduler]; 
}
- (RACSignal *)localInstructions
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSArray *instructions = [[SXQDBManager sharedManager] localInstructions];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:instructions];
                [subscriber sendCompleted];
            });
            
        });
        return nil;
    }];
}
- (RACSignal *)changeUserIconSignalWithUserImage:(UIImage *)image
{
    DWMeEditParam *param = [[DWMeEditParam alloc] init];
    NSData *imageData = UIImageJPEGRepresentation(image,0);
    param.iconStream = [NSString base64forData:imageData];
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:EditUserInfoURL params:param.mj_keyValues success:^(id json) {
            [subscriber sendNext:@([json[@"code"] isEqualToString:@"1"])];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
- (RACSignal *)userIconSignal
{
    SXQBaseParam *param = [[SXQBaseParam alloc] init];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:UserIconURL params:param.mj_keyValues success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                DWUserIcon *userIcon = [DWUserIcon mj_objectWithKeyValues:json[@"data"]];
                [subscriber sendNext:userIcon];
            }else
            {
                [subscriber sendNext:nil];
            }
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            
        }];
        return nil;
    }];
}
@end
