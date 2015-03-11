//
//  web.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-7.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "Webservices.h"
#import "NetWebServiceRequest.h"
#import "SoapXmlParseHelper.h"
@interface Webservices ()<NetWebServiceRequestDelegate>

@property (nonatomic, retain)NetWebServiceRequest *runningRequest;

@end


@implementation Webservices
@synthesize delegate = _delegate;
@synthesize runningRequest = _runningRequest;
@synthesize tag;
-(id) init{
    return self;
}
-(NSString *)GetResponseString
{
    return responseString;
}

- (NSMutableArray *)GetResponseArray
{
    return responseArray;
}
-(void)requestKangFuWithMethodName:(NSString *)methodName Params:(NSArray *)propertyKeys Values:(NSArray *)propertyValues
{
    //定义soapMessage
    NSMutableString *soapMessage = [NSMutableString stringWithFormat:@"%@%@",SOAP_MESSAGE_HEADER_KANGFU,SOAP_MESSAGE_METHODHEAD_KANGFU(methodName)];
  
        
    
    for (NSInteger index=0; index<[propertyValues count]; index++) {
        
        NSString *key = [propertyKeys objectAtIndex:index];
        
        NSString *value = [propertyValues objectAtIndex:index];
        
        [soapMessage appendString: SOAP_MESSAGE_PARAM_KANGFU(key, value)];
    }
    
    
    [soapMessage appendFormat:@"%@%@",SOAP_MESSAGE_METHODFOOT_KANGFU(methodName),SOAP_MESSAGE_FOOTER_JIANGBIN];
    
    
    //请求发送到的路径
    NSString *url = [NSString stringWithFormat:@"%@/%@",WEBSERVICE_KANGFU,methodName];
    
    NSString *soapActionURL = [NSString stringWithFormat:@"%@/%@",SOAP_ACTION_KANGFU,methodName];
    
    // 请求webservice
    NetWebServiceRequest *request = [NetWebServiceRequest serviceRequestUrl:url SOAPActionURL:soapActionURL ServiceMethodName:methodName SoapMessage:soapMessage];
    
    request.delegate = self;
    
    [request startAsynchronous];
    
    self.runningRequest = request;
    
}
-(void)requestJiangBinWithMethodName:(NSString *)methodName Params:(NSArray *)propertyKeys Values:(NSArray *)propertyValues
{
    //定义soapMessage

    NSMutableString *soapMessage = [NSMutableString stringWithFormat:@"%@%@",SOAP_MESSAGE_HEADER_JIANGBIN,SOAP_MESSAGE_METHODHEAD_JIANGBIN(methodName)];

    for (NSInteger index=0; index<[propertyValues count]; index++) {
        NSString *key = [propertyKeys objectAtIndex:index];
        NSString *value = [propertyValues objectAtIndex:index];
        [soapMessage appendString:SOAP_MESSAGE_PARAM_JIANGBIN(key, value)];
    }
    [soapMessage appendFormat:@"%@%@",SOAP_MESSAGE_METHODFOOT_JINAGBIN(methodName),SOAP_MESSAGE_FOOTER_JIANGBIN];
    
    
    //请求发送到的路径
    NSString *url = [NSString stringWithFormat:@"%@",WEBSERVICE_RIVERSIDE];
   
    NSString *soapActionURL = [NSString stringWithFormat:@"%@/%@",SOAP_ACTION_RIVERSIDE,methodName];
    
    // 请求webservice
    NetWebServiceRequest *request = [NetWebServiceRequest serviceRequestUrl:url SOAPActionURL:soapActionURL ServiceMethodName:methodName SoapMessage:soapMessage];
    request.delegate = self;
    [request startAsynchronous];
    
    self.runningRequest = request;
}
#pragma mark - network delegate
-(void)netRequestStarted:(NetWebServiceRequest *)request
{
    responseString  = [[NSString alloc] init];
    responseArray = [[NSMutableArray alloc] init];
}

-(void)netRequestFinished:(NetWebServiceRequest *)request finishedInfoToResult:(NSString *)result responseData:(NSData *)requestData
{
    responseString = result;

    responseArray = [SoapXmlParseHelper XmlToArray:result];
   
    if ([responseArray count]==0) {
        [responseArray addObject:result];
    }
    if ([self.delegate respondsToSelector:@selector(WebservicesFinished:)]) {
        [self.delegate WebservicesFinished:self];
    }
    
    
}
-(void)netRequestFailed:(NetWebServiceRequest *)request didRequestError:(NSError *)error
{
//    NSLog(@"错误提示 = %@",error);
}
-(void)serviceRequestFinished
{
    
}
-(void)dealloc{
    [super dealloc];
    
    [responseString release];
    [responseArray release];
}
@end
