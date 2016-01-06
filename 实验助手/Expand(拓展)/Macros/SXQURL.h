//
//  SXQURL.h
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#ifndef _____SXQURL_h
#define _____SXQURL_h
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,LABResponseType)
{
    LABResponseTypeFailure = 0,
    LABResponseTypeSuccess = 1,
};

////////////////////////////////////////////实验部分////////////////////////////////////
#define SetReagentURL @"map/setReagents"
//获取实验或说明书下所有的实验步骤
#define ExperimentStepURL @"lab/getAllProcessExceptComplete"
//附近的试剂交换
#define AdjacentReagentURL @"map/around"
//正在进行的实验
#define DoingExpURL @"lab/getDoing"
//已完成的实验
#define DoneExpURL @"lab/getComplete"
// 获取实验所需的试剂
#define ReagentListURL @"lab/allReagents"
//获取实验试剂及对应的厂商
#define ReagentSupplierURL @"lab/reagentAndSupplier"
//获取实验试剂及对应的用量
#define ReagentPerAmountURL @"lab/perAmount"
//根据输入的查询条件筛选实验说明书
#define SearchInstruction @"lab/getInstructionsByFilter"
//上传每步实验步骤所拍的照片
#define UploadExpProcessImgsURL @"upload/perExpProcessImgs"
//同步实验部分
#define SynExperimentURL @"pdf"
//实验报告列表
#define ExperimentReportListURL @"pdf/pdfList"
#define ExperimentReportDownloadURL @"pdf/downloadPdf"
//下载实验报告
#define CommentListURL @"lab/reviewOptional"
////////////////////////////////////////////实验部分////////////////////////////////////

//////////////////////////////说明书//////////////////////////////////////////////////////
#define InstructionMainURL @"expCategory/getAllCategory"
//所有说明书
#define AllExpURL @"expCategory/allExpCategory"
//二级分类
#define SubExpURL @"expCategory/getSubCategoryByPID"
//说明书列表
#define InstructionListURL @"lab/getInstructionsBySubCategoryID"
//说明书下载
#define DownloadInstructionURL @"lab/downloadInstruction"
//说明书详情
#define InstructionDetailURL @"lab/getInstructionDetail"
//热门说明书
#define HotInstructionsURL @"lab/getHotInstructions"
//搜索说明书
#define SearchInstructionURL @"lab/getInstructionsByFilter"
//评论详情
#define CommentDetailURL @"lab/reviewDetail"
//试剂详情
#define ReagentDetailURL @"lab/expReagentDetail"
//评论
#define CommentURL @"lab/responseReview"
//////////////////////////////说明书//////////////////////////////////////////////////////

#define SupplierURL @"sync/pullCommon"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define LoginURL @"login"
#define SignUpURL @"register"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define ScheduleURL @"lab/getMyExpPlan"
#define DeleteScheduleURL @"lab/deleteMyExpPlan"
#define AddScheduleURL @"lab/setMyExpPlan"
#define ForgetPassURL @"findPwd"
//资讯
#define NewsURL @"grabNews"
#define ProvinceURL @"myInfo/provinceAndCity"
//职称列表
#define IdentityURL @"myInfo/titles"
//学历列表
#define DegreeURL @"myInfo/educations"
//学校列表
#define SchoolURL @"myInfo/colleges"
#define ProfessionURL @"myInfo/educations"
#define UserInfoURL @"myInfo/basic"
#define EditUserInfoURL @"myInfo/edit"
#define UserIconURL @"myInfo/icon"
/**
 *  bbs
 */
#define BBSModulesURL @"bbs/modules"
#define BBSThemesURL @"bbs/topics"
#define BBSCommentsURL @"bbs/reviews"
#define BBSWriteCommentURL @"bbs/responseReview"
#define BBSThemeSearchURL @"bbs/searchTopics"
#define BBSAddThemeURL @"bbs/releaseTopic"
/**
 *  append item
 */
#define ReagentFirstClarifyURL @"create/levelOne"
#define ReagentSecondClarifyURL @"create/levelTwo"
#define GetReagentURL @"create/getReagents"
#define GetSupplierURL @"create/getSuppliers"
#define SearchItemURL @"create/search"
#define FetchAddConsumabelsURL @"create/getConsumables"
#define FetchAddEquipmentsURL @"create/getEquipments"
/**
 *  同步实验说明书
 */
#define SyncInstructionURL @"sync/pushExpInstruction"
#endif
