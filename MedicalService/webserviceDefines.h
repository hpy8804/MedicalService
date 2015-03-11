//
//  webserviceDefines.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-6.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#ifndef MedicalService_webserviceDefines_h
#define MedicalService_webserviceDefines_h
enum{
    ordinaryOutpatient = 3,
    expertOutpatient = 4,
};
enum{
    KangFuTag = 1,
    JiangBinTag = 2,
};
enum{
    hospitalAcionTag = 1001,
    departmentActionTag = 1002,
};
// 康复医院soap相关信息
#define WEBSERVICE_KANGFU          @"http://www.jskfhn.org.cn/CallCenterWebService/Interface/AppointmentService.asmx?WSDL"

#define SOAP_ACTION_KANGFU         @"http://tempuri.org"

#define SOAP_MESSAGE_HEADER_KANGFU @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">\n""<soapenv:Header/>\n""<soapenv:Body>\n"

#define SOAP_MESSAGE_METHODHEAD_KANGFU(methodName) [NSString stringWithFormat:@"<tem:%@>\n",methodName]

#define SOAP_MESSAGE_METHODFOOT_KANGFU(methodName) [NSString stringWithFormat:@"</tem:%@>\n",methodName]

#define SOAP_MESSAGE_PARAM_KANGFU(paramName,Value) [NSString stringWithFormat:@"<tem:%@>%@</tem:%@>\n",paramName,value,paramName]

// 江滨医院soap相关信息
#define WEBSERVICE_RIVERSIDE       @"http://www.jdfyyygh.com:8080/service/public?wsdl"

#define SOAP_ACTION_RIVERSIDE      @"http://service.pub.itf.nc/IApptPublicService"

#define SOAP_MESSAGE_HEADER_JIANGBIN @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:iap=\"http://service.pub.itf.nc/IApptPublicService\">\n""<soapenv:Header/>\n""<soapenv:Body>\n"

#define SOAP_MESSAGE_METHODHEAD_JIANGBIN(methodName) [NSString stringWithFormat:@"<iap:%@>\n",methodName]

#define SOAP_MESSAGE_METHODFOOT_JINAGBIN(methodName) [NSString stringWithFormat:@"</iap:%@>\n",methodName]

#define SOAP_MESSAGE_FOOTER_JIANGBIN @"</soapenv:Body>\n""</soapenv:Envelope>\n"

#define SOAP_MESSAGE_PARAM_JIANGBIN(paramName,value) [NSString stringWithFormat:@"<%@>%@</%@>\n",paramName,value,paramName]

#endif
