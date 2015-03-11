//
//  getPatientInfo.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "getPatientInfo.h"
#import "patientInfo.h"
#import "NSString+block.h"
#import "GetXML.h"
@interface getPatientInfo ()<WebservicesDelegate>{
    Webservices *webservice;
    GetXML *xmlParser;
    NSString *message;
    NSMutableArray *infoResultArray;
}

@end

@implementation getPatientInfo
-(id)initPatient
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        infoResultArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(NSString *)getMessage
{
    return message;
}
-(NSMutableArray *)getPatientInfoArray
{
    return infoResultArray;
}
-(void)getpatientInfoByHospitalCode:(NSString *)hospitalCode PatientName:(NSString *)patientName IDNumber:(NSString *)IdNumber Phone:(NSString *)phone CardNumber:(NSString *)cardNumber
{
    webservice.delegate = self;
    webservice.tag = JiangBinTag;
    NSMutableArray *params = [NSMutableArray arrayWithObjects:@"arg0",@"arg1",@"arg2",@"arg3", nil];
    NSMutableArray *values = [NSMutableArray arrayWithObjects:hospitalCode,patientName,IdNumber,phone, nil];
    if (cardNumber!=nil) {
        [params addObject:@"arg4"];
        [values addObject:cardNumber];
    }
    NSString *methodName = @"getPatientInfo";
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    NSString *responseString = [theWebservice GetResponseString];
    responseString  = [NSString cutForJiangBin:responseString];
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
        if ([dic objectForKey:@"patientId"]!=nil) {
            patientInfo *infoModel = [[patientInfo alloc] init];
            infoModel.patientId = [dic objectForKey:@"patientId"];
            infoModel.patientName = [dic objectForKey:@"patientName"];
            infoModel.gender = [dic objectForKey:@"gender"];
            infoModel.birthDate = [dic objectForKey:@"birthDate"];
            infoModel.idType = [dic objectForKey:@"idType"];
            infoModel.idNumber= [dic objectForKey:@"idNumber"];
            infoModel.phone = [dic objectForKey:@"phone"];
            infoModel.cardNumber= [dic objectForKey:@"cardNumber"];
            infoModel.state= [dic objectForKey:@"state"];
            [infoResultArray addObject:infoModel];
            [infoModel release];
        }
    }
   
    if ([code integerValue]==0&&[_delegate respondsToSelector:@selector(getPatientInfoSuccess:)]) {
        [self.delegate getPatientInfoSuccess:self];
    }
    else if([code integerValue]==1&&[_delegate respondsToSelector:@selector(getPatientInfoFailed:)]){
        [self.delegate getPatientInfoFailed:self];
    }

}
// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[GetXML alloc] init];
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"patientId",@"patientName",@"gender",@"birthDate",@"idType",@"idNumber",@"phone",@"cardNumber",@"state", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"patient", nil];
    [xmlParser parseWithData:data];
    return [xmlParser getFinalArray];
}
-(void)dealloc{
    [super dealloc];
    webservice.delegate = nil;
    [webservice release];
    [infoResultArray release];
}
@end
