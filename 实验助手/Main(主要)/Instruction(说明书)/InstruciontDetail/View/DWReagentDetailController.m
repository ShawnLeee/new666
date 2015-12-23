//
//  DWReagentDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWReagentDetail.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpReagent.h"
#import "DWReagentDetailController.h"

@interface DWReagentDetailController ()
@property (nonatomic,weak) IBOutlet UILabel *reagentNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *chemicalLabel;
@property (nonatomic,weak) IBOutlet UILabel *supplierLabel;
@property (nonatomic,weak) IBOutlet UILabel *firstLabel;
@property (nonatomic,weak) IBOutlet UILabel *secondeLabel;
@property (nonatomic,weak) IBOutlet UILabel *placeLabel;
@property (nonatomic,weak) IBOutlet UILabel *productNumLabel;
@property (nonatomic,weak) IBOutlet UILabel *createLabel;
@property (nonatomic,weak) IBOutlet UILabel *guigeLabel;
@property (nonatomic,weak) IBOutlet UILabel *casnumLabel;
@property (nonatomic,weak) IBOutlet UILabel *demonstrationLabel;
@property (nonatomic,strong) SXQExpReagent *reagent;
@property (nonatomic,strong) id<DWInstructionService> service;
@end

@implementation DWReagentDetailController
- (instancetype)initWithExpReagent:(SXQExpReagent *)reagent service:(id<DWInstructionService>)service
{
    if (self = [super init]) {
        _reagent = reagent;
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"试剂详情";
    [self p_loadData];
}
- (void)p_loadData
{
    [[self.service reagentSignalWithReagentModel:self.reagent]
    subscribeNext:^(DWReagentDetail *reagentDetail) {
        [self p_updateUIWithReagentDetail:reagentDetail];
    }];
    
}
- (void)p_updateUIWithReagentDetail:(DWReagentDetail *)reagentDetail
{
    self.reagentNameLabel.text = reagentDetail.reagentName;
    self.chemicalLabel.text = reagentDetail.chemicalName;
    self.supplierLabel.text = reagentDetail.supplier;
    self.firstLabel.text = reagentDetail.levelOne;
    self.secondeLabel.text = reagentDetail.levelTwo;
    self.placeLabel.text = reagentDetail.originPlace;
    self.productNumLabel.text = reagentDetail.productNo;
    self.createLabel.text = reagentDetail.agents;
    self.guigeLabel.text = reagentDetail.specification;
    self.casnumLabel.text = reagentDetail.casNo;
    self.demonstrationLabel.text = reagentDetail.memo;
}
@end
