//
//  SXQURL.h
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
//hualang.wicpnet:8090
#ifndef _____SXQURL_h
#define _____SXQURL_h
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,LABResponseType)
{
    LABResponseTypeFailure = 0,
    LABResponseTypeSuccess = 1,
};

#define sURL @"hualang.wicp.net:8090"
//#define sURL @"127.0.0.1:9090"
//#define sURL @"172.18.1.55:8080"
//#define sURL @"120.25.78.13:8080/"

////////////////////////////////////////////实验部分////////////////////////////////////
#define SetReagentURL @"http://"sURL"/LabAssistant/map/setReagents"
//获取实验或说明书下所有的实验步骤
#define ExperimentStepURL @"http://"sURL"/LabAssistant/lab/getAllProcessExceptComplete"
//附近的试剂交换
#define AdjacentReagentURL @"http://"sURL"/LabAssistant/map/around"
//正在进行的实验
#define DoingExpURL @"http://"sURL"/LabAssistant/lab/getDoing"
//已完成的实验
#define DoneExpURL @"http://"sURL"/LabAssistant/lab/getComplete"
// 获取实验所需的试剂
#define ReagentListURL @"http://"sURL"/LabAssistant/lab/allReagents"
//获取实验试剂及对应的厂商
#define ReagentSupplierURL @"http://"sURL"/LabAssistant/lab/reagentAndSupplier"
//获取实验试剂及对应的用量
#define ReagentPerAmountURL @"http://"sURL"/LabAssistant/lab/perAmount"
//根据输入的查询条件筛选实验说明书
#define SearchInstruction @"http://"sURL"/LabAssistant/lab/getInstructionsByFilter"
//上传每步实验步骤所拍的照片
#define UploadExpProcessImgsURL @"http://"sURL"/LabAssistant/upload/perExpProcessImgs"
//同步实验部分
#define SynExperimentURL @"http://"sURL"/LabAssistant/pdf"
//实验报告列表
#define ExperimentReportListURL @"http://"sURL"/LabAssistant/pdf/pdfList"
#define ExperimentReportDownloadURL @"http://"sURL"/LabAssistant/pdf/downloadPdf"
//下载实验报告
#define CommentListURL @"http://"sURL"/LabAssistant/lab/reviewOptional"
////////////////////////////////////////////实验部分////////////////////////////////////

//////////////////////////////说明书//////////////////////////////////////////////////////
#define InstructionMainURL @"http://"sURL"/LabAssistant/expCategory/getAllCategory"
//所有说明书
#define AllExpURL @"http://"sURL"/LabAssistant/expCategory/allExpCategory"
//二级分类
#define SubExpURL @"http://"sURL"/LabAssistant/expCategory/getSubCategoryByPID"
//说明书列表
#define InstructionListURL @"http://"sURL"/LabAssistant/lab/getInstructionsBySubCategoryID"
//说明书下载
#define DownloadInstructionURL @"http://"sURL"/LabAssistant/lab/downloadInstruction"
//说明书详情
#define InstructionDetailURL @"http://"sURL"/LabAssistant/lab/getInstructionDetail"
//热门说明书
#define HotInstructionsURL @"http://"sURL"/LabAssistant/lab/getHotInstructions"
//搜索说明书
#define SearchInstructionURL @"http://"sURL"/LabAssistant/lab/getInstructionsByFilter"
//评论详情
#define CommentDetailURL @"http://"sURL"/LabAssistant/lab/reviewDetail"
//试剂详情
#define ReagentDetailURL @"http://"sURL"/LabAssistant/lab/expReagentDetail"
//评论
#define CommentURL @"http://"sURL"/LabAssistant/lab/responseReview"
//////////////////////////////说明书//////////////////////////////////////////////////////

#define SupplierURL @"http://"sURL"/LabAssistant/sync/pullCommon"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define LoginURL @"http://"sURL"/LabAssistant/login"
#define SignUpURL @"http://"sURL"/LabAssistant/register"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define ScheduleURL @"http://"sURL"/LabAssistant/lab/getMyExpPlan"
#define DeleteScheduleURL @"http://"sURL"/LabAssistant/lab/deleteMyExpPlan"
#define AddScheduleURL @"http://"sURL"/LabAssistant/lab/setMyExpPlan"
#define ForgetPassURL @"http://"sURL"/LabAssistant/findPwd"
//资讯
#define NewsURL @"http://"sURL"/LabAssistant/grabNews"
#define ProvinceURL @"http://"sURL"/LabAssistant/myInfo/provinceAndCity"
//职称列表
#define IdentityURL @"http://"sURL"/LabAssistant/myInfo/titles"
//学历列表
#define DegreeURL @"http://"sURL"/LabAssistant/myInfo/educations"
//学校列表
#define SchoolURL @"http://"sURL"/LabAssistant/myInfo/colleges"
#define ProfessionURL @"http://"sURL"/LabAssistant/myInfo/educations"
#define UserInfoURL @"http://"sURL"/LabAssistant/myInfo/basic"
#define EditUserInfoURL @"http://"sURL"/LabAssistant/myInfo/edit"
#define UserIconURL @"http://"sURL"/LabAssistant/myInfo/icon"
/**
 *  bbs
 */
#define BBSModulesURL @"http://"sURL"/LabAssistant/bbs/modules"
#define BBSThemesURL @"http://"sURL"/LabAssistant/bbs/topics"
#define BBSCommentsURL @"http://"sURL"/LabAssistant/bbs/reviews"
#define BBSWriteCommentURL @"http://"sURL"/LabAssistant/bbs/responseReview"
#define BBSThemeSearchURL @"http://"sURL"/LabAssistant/bbs/searchTopics"
#define BBSAddThemeURL @"http://"sURL"/LabAssistant/bbs/releaseTopic"
/**
 *  append item
 */
#define ReagentFirstClarifyURL @"http://"sURL"/LabAssistant/create/levelOne"
#define ReagentSecondClarifyURL @"http://"sURL"/LabAssistant/create/levelTwo"
#define GetReagentURL @"http://"sURL"/LabAssistant/create/getReagents"
#define GetSupplierURL @"http://"sURL"/LabAssistant/create/getSuppliers"
#define SearchItemURL @"http://"sURL"/LabAssistant/create/search"
#define FetchAddConsumabelsURL @"http://"sURL"/LabAssistant/create/getConsumables"
#define FetchAddEquipmentsURL @"http://"sURL"/LabAssistant/create/getEquipments"
/**
 *  同步实验说明书
 */
#define SyncInstructionURL @"http://"sURL"/LabAssistant/sync/pushExpInstruction"
#endif
