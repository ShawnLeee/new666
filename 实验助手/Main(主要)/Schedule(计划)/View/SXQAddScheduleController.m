//
//  SXQAddScheduleController.m
//  实验助手
//
//  Created by sxq on 15/11/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQScheduleServicesImpl.h"
#import "SXQExpPlan.h"
#import "SXQAddScheduleController.h"

@interface SXQAddScheduleController ()
@property (nonatomic,strong) SXQExpPlan *expPlan;
@property (nonatomic,strong) id<SXQScheduleServices> services;
@end

@implementation SXQAddScheduleController
- (id<SXQScheduleServices>)services
{
    if (_services == nil) {
        _services = [[SXQScheduleServicesImpl alloc] init];
    }
    return _services;
}
- (instancetype)initWithExpPlan:(SXQExpPlan *)expPlan
{
    if (self = [super init]) {
        _expPlan = expPlan;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case SectionTypeHotInstructionType:
        {
            DWGroup *group = self.groups[indexPath.section];
            SXQHotInstruction *instruction = group.items[indexPath.row];
            self.expPlan.expInstructionID = instruction.expInstructionID;
            self.expPlan.experimentName = instruction.experimentName;
            [self addSchedule];
            break;
        }
        case SectionTypeMyInstructionType:
        {
            DWGroup *group = self.groups[indexPath.section];
            SXQMyGenericInstruction *genericInstruciton = group.items[indexPath.row];
            self.expPlan.expInstructionID = genericInstruciton.expInstructionID;
            self.expPlan.experimentName = genericInstruciton.experimentName;
            [self addSchedule];
            break;
        }
        default:
            break;
    }
}
- (void)addSchedule
{
    [[[[self services] getServices] addScheduleSignalWithExpPlan:self.expPlan]
     subscribeNext:^(NSNumber *success) {
         if ([success boolValue]) {
             [self.navigationController popViewControllerAnimated:YES];
         }
    }];
}
@end
