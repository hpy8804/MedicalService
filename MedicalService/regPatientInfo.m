//
//  regPatientInfo.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-22.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "regPatientInfo.h"

#import "NSString+block.h"
#import "GetXML.h"
@interface regPatientInfo ()<WebservicesDelegate>{
    Webservices *webservice;
    NSString *patientId;
    NSString *message;
    GetXML *xmlParser;
}

@end

@implementation regPatientInfo
-(id)initReg{
    
    if (self = [self init]) {
        webservice = [[Webservices alloc] init];
        patientId = [[NSString alloc] init];
    }
    
    
    return self;
}
-(NSString *)getMessage
{
    return message;
}
-(NSString *)getPatientId{
    return patientId;
}
// 请求数据 注册

-(void)regPatientInfoWithHospitalCode:(NSString *)hospitalCode PatientName:(NSString *)patientName Birthday:(NSString *)brithday Gender:(NSString *)gender IDNumber:(NSString *)IdNumber Phone:(NSString *)phone
{
    webservice.tag=JiangBinTag;
    
    webservice.delegate = self;
    
    NSString *methodName = @"regPatientInfo";
    
    /*
     * arg0:医院编码       arg1:病人姓名 arg2:性别(1男2女) arg3:出生日期
     * arg4:证件类型(传值0) arg5:证件号码 arg6:电话号码
     * 不需要的参数 直接不传，并不是传值为空
     */
    NSArray *params = [NSArray arrayWithObjects:@"arg0",@"arg1",@"arg2",@"arg3",@"arg4",@"arg5",@"arg6", nil];
    NSArray *values = [NSArray arrayWithObjects:hospitalCode,patientName, gender,brithday,@"0",IdNumber,phone, nil];
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
    
}

// 请求成功后回调方法
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    NSString *responseString = [theWebservice GetResponseString];
    responseString = [NSString cutForJiangBin:responseString];
    NSMutableArray *array = [self getXMLString:responseString];
    message = [[NSString alloc] init];
    NSString *code = [NSString string];
    for(NSDictionary *dic in array){
        if ([dic objectForKey:@"code"]!=nil) {
            code = [dic objectForKey:@"code"];
        }
        if ([dic objectForKey:@"msg"]!=nil) {
            message = [dic objectForKey:@"msg"];
        }
        if ([dic objectForKey:@"patientId"]!=nil){
            patientId = [dic objectForKey:@"patientId"];
        }
        
    }
    if ([code integerValue] == 0&&[_delegate respondsToSelector:@selector(getPatientInfoFinished:)]) {
        [self.delegate getPatientInfoFinished:self];
    }
    else if([code integerValue]==1&&[_delegate respondsToSelector:@selector(registerFailed:)]){
        [self.delegate registerFailed:self];
    }
}

// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[GetXML alloc] init];
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"patientId", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"patientId", nil];
    [xmlParser parseWithData:data];
    return [xmlParser getFinalArray];
}
-(void)dealloc{
    [super dealloc];
    webservice.delegate = nil;
    [webservice release];
    [patientId release];
}
@end
