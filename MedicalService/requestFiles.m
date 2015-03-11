//
//  requestFiles.m
//  MedicalService
//
//  Created by 张琼芳 on 14-1-16.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "requestFiles.h"
#import "parseXmlToArray.h"
#import "NSString+block.h"
#import "GetXML.h"

@interface requestFiles ()<NetWebServiceRequestDelegate>
{
    NSMutableArray *responseArray;
}
@property (nonatomic, retain)NetWebServiceRequest *runningRequest;

@end

@implementation requestFiles
-(NSMutableArray *)responseArray
{
    return responseArray;
}

//拼接soapMessage
-(NSString *)soapMessage:(NSString *)methodName Params:(NSArray *)params
{
   
    // 添加soap头
    NSMutableString *soapMessage = [NSMutableString stringWithFormat:@"%@\n%@",HEALTH_SOAP_HEADER,HEALTH_METHOD_HEADER(methodName)];
    // 添加参数部分
    for(NSInteger index = 0;index<[params count];index++){
        NSString *param = [NSString stringWithFormat:@"arg%d",index];
        NSString *value = [params objectAtIndex:index];
        [soapMessage appendFormat:@"\n<%@>%@</%@>",param,value,param];
    }
    // 添加方法尾
    [soapMessage appendFormat:@"\n%@",HEALTH_METHOD_FOOTER(methodName)];
    
    // 添加soap信息尾
    [soapMessage appendFormat:@"\n%@",HEALTH_SOAP_FOOTER];
    
    
    return soapMessage;
    
}
// 开始webservice请求
-(void)requestBeginWithMethod:(FLHealthMethod)method Params:(NSArray *)params
{
    // 得到请求方法名
    NSString *methodName= [METHODS objectAtIndex:method];
    
    // 得到soapMessage
    NSString *soapMessage = [self soapMessage:methodName Params:params];
    //请求发送到的路径
    NSString *url = [NSString stringWithFormat:@"%@",HEALTH_FILE_ADDRESS];
    // 获取soapAction
//    NSString *soapActionURL = [NSString stringWithFormat:@"%@",HEALTH_SOAP_ACTION];
    
    
    // 请求webservice
    NetWebServiceRequest *request = [NetWebServiceRequest serviceRequestUrl:url SOAPActionURL:@"" ServiceMethodName:methodName SoapMessage:soapMessage];
    
    request.delegate = self;
    
    [request startAsynchronous];
    
    self.runningRequest = request;
}
#pragma mark - net Delegate
// 开始请求
-(void)netRequestStarted:(NetWebServiceRequest *)request
{
    responseArray = [[NSMutableArray alloc] init];
}
// 请求成功
-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData
{
    NSString *responseString = [NSString cutForJiangBin:result];
//    NSLog(@"%@",responseString);
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    parseXmlToArray *xml =[[parseXmlToArray alloc] init];
    [xml parseXmlWithData:data];
    responseArray = [xml getXmlArray];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getFilesFinished:)]) {
        [self.delegate getFilesFinished:self];
    }
}
// 请求失败
-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getFilesFailed:)]) {
        [self.delegate getFilesFailed:self];
    }
}
@end
