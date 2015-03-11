//
//  weblink.h
//  MedicalService
//
//  Created by 张琼芳 on 13-12-31.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#ifndef MedicalService_weblink_h
#define MedicalService_weblink_h
// 个人档案
enum {
    personalBasicInfoTag,
    personalExtraInfoTag,
    outPatientSummaryListTag,
    hospitalSummaryListTag,
};
// 摘要信息
enum {
    outPatientSummaryDetailTag,
    hospitalSummaryDetailTag,
};
//更多信息
enum {
    outPatientMedicineTag,
    outpatientExpenseTag,
    outpatientInspectionTag,
    hospitalMedicineTag,
    hospitalExpenseTag,
    hospitalInspectionTag,
};
// 网络请求
typedef NS_ENUM(NSInteger,FLHealthMethod)
{
    loginRequest,// 登陆
    personalBasicInfo,//个人基本信息
    personalExtraInfo,//个人补充信息
    summaryListInfoOfOupatient,//门诊摘要信息列表
    summaryInfoOfOutpatient,// 门诊摘要信息
    medicineInfoOfOutpatient,//门诊用药信息
    expenseInfoOfOutpatient,// 门诊费用信息
    inspectionInfoOfOutpatient,//门诊检验信息
    summaryListInHospital,// 住院摘要列表信息
    summaryInfoInHospital,//住院摘要信息
    medicineInfoInHospital,// 住院用药信息
    expenseInfoInHospital,// 住院费用信息
    inspectionInfoInHospital,//住院检查信息
    
};
#define METHODS [NSMutableArray arrayWithObjects:@"GD_DR",@"GD_GRJBXX",@"GD_GRBCXX",@"GD_MZ_ZYXX_LIST",@"GD_MZ_ZYXX",@"GD_MZ_YYXX",@"GD_MZ_FYXX",@"GD_MZ_JYJC",@"GD_ZY_ZYXX_LIST",@"GD_ZY_ZYXX",@"GD_ZY_YYXX",@"GD_ZY_FYXX",@"GD_ZY_JYJC",nil]
#define MEDICINE_TITLES [NSArray arrayWithObjects:@"中药类别",@"药物类型",@"药物名称",@"药物剂型",@"用药天数",@"使用频率",@"剂量单位",@"使用次剂量",@"使用总剂量",@"使用途径",@"停止使用日期",@"用法要求",@"用药时间",nil]

#define MEDICINE_KEYS [NSArray arrayWithObjects:@"ZYLBMC",@"YWLXMC",@"YWMC",@"YWJXMC",@"YYTS",@"YWSYPLMC",@"YWSYJLDW",@"YWSYCJL",@"YWSYZJL",@"YWSYTJMC",@"YYTZRQSJ",@"YWYFYQ",@"YYSJ",nil]
#define EXPENSE_TITLES [NSArray arrayWithObjects:@"费用分类",@"金额",@"费用来源",@"结算方式",nil]
#define EXPENSE_KEYS [NSArray arrayWithObjects:@"FYFLMC",@"FYJE",@"YLFYLYFSMC",@"FYJSFSMC",nil]
#define INSPECTION_TITLES [NSArray arrayWithObjects:@"检验类别",@"检验项目",@"检验结果",@"定量结果",@"计量单位",nil]
#define INSPECTION_KEYS [NSArray arrayWithObjects:@"JCJYLBMC",@"JCJYXMMC",@"JCJYJGMC",@"JCJYDLJG",@"JCJYJLDW",nil]


#define HEALTH_FILE_ADDRESS @"http://221.131.76.20:9082/rhipcxf/services/gdws?WSDL"
#define HEALTH_SOAP_ACTION  @"http://service.gd.rhipcxf.com/"
#define HEALTH_SOAP_HEADER   @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.gd.rhipcxf.com/\">\n""<soapenv:Header/>\n""<soapenv:Body>"
#define HEALTH_METHOD_HEADER(method) [NSString stringWithFormat: @"<ser:%@>",method]
#define HEALTH_METHOD_FOOTER(method) [NSString stringWithFormat: @"</ser:%@>",method]
#define HEALTH_SOAP_FOOTER            @"</soapenv:Body>\n""</soapenv:Envelope>"

#endif
