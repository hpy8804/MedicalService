//
//  queryAppRecord.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "queryAppRecord.h"
#import "GetXML.h"
#import "NSString+block.h"
#import "appRecordModel.h"
@interface queryAppRecord ()<WebservicesDelegate>{
    Webservices *webservice;
    GetXML *xmlParser;
    NSString *message;
    NSMutableArray *appointmentRecords;
}

@end

@implementation queryAppRecord

-(id)initRecord
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        appointmentRecords = [[NSMutableArray alloc] init];
    }
    return  self;
}
-(NSString *)getMessage
{
    return message;
}
-(NSMutableArray *)getRecordArray
{
    return appointmentRecords;
}
-(void)searchAppointmentByPatientName:(NSString *)patientName Telephone:(NSString *)telephone IDNumber:(NSString *)idNumber
{
    webservice.delegate = self;
    webservice.tag = KangFuTag;
    NSString *methodName = @"SearchAppointment";
    NSArray *params = [NSArray arrayWithObjects:@"patName",@"telephone",@"IDNum", nil];
    NSArray *values = [NSArray arrayWithObjects:patientName,telephone,idNumber, nil];
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)queryRecordByPhoneNumber:(NSString *)phoneNumber OrIdNumber:(NSString *)IDNumber
{
    webservice.delegate = self;
    webservice.tag = JiangBinTag;
    NSString *methodName = @"searchAppointment";
    NSMutableArray *params = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    if (phoneNumber!=nil) {
        [params addObject:@"arg0"];
        [values addObject:phoneNumber];
    }
    if (IDNumber!=nil) {
        [params addObject:@"arg1"];
        [values addObject:IDNumber];
    }
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];

}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    if (theWebservice.tag==KangFuTag) {
        NSMutableArray *object = [theWebservice GetResponseArray];
        if ([object count]==0||[[object lastObject] isKindOfClass:[NSString class]]) {
            if ([_delegate respondsToSelector:@selector(RequestPatientFailed:)]) {
                [self.delegate RequestPatientFailed:self];
            }
            return;
        }
        for(NSDictionary *dic in object){
            NSArray *array = [dic objectForKey:@"Appointment"];
            
            for(NSDictionary *value in array){
                appRecordModelKangFu *model = [[appRecordModelKangFu alloc] init];
                if ([[value objectForKey:@"Name"] isKindOfClass:[NSArray class]]) {
                    model.name = [[[value objectForKey:@"Name"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"Phone"] isKindOfClass:[NSArray class]]) {
                    model.phone = [[[value objectForKey:@"Phone"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"CardNo"] isKindOfClass:[NSArray class]]) {
                    model.cardNo = [[[value objectForKey:@"CardNo"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"CardType"] isKindOfClass:[NSArray class]]) {
                    model.cardType = [[[value objectForKey:@"CardType"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"Sex"] isKindOfClass:[NSArray class]]) {
                    model.Sex = [[[value objectForKey:@"Sex"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"IDNum"] isKindOfClass:[NSArray class]]) {
                    model.IDNum = [[[value objectForKey:@"IDNum"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"DeptName"] isKindOfClass:[NSArray class]]) {
                    model.DeptName = [[[value objectForKey:@"DeptName"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"ExpertName"] isKindOfClass:[NSArray class]]) {
                    model.ExpertName = [[[value objectForKey:@"ExpertName"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"RegistNumber"] isKindOfClass:[NSArray class]]) {
                    model.RegisterNumber = [[[value objectForKey:@"RegistNumber"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"SliceStartTime"] isKindOfClass:[NSArray class]]) {
                    model.SliceStartTime = [[[value objectForKey:@"SliceStartTime"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"Status"] isKindOfClass:[NSArray class]]) {
                    model.Status = [[[value objectForKey:@"Status"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"OrderId"] isKindOfClass:[NSArray class]]) {
                    model.OrderId = [[[value objectForKey:@"OrderId"] objectAtIndex:0] objectForKey:@"text"];
                }
                if ([[value objectForKey:@"ResourceId"] isKindOfClass:[NSArray class]]) {
                    model.resourceId = [[[value objectForKey:@"ResourceId"] objectAtIndex:0] objectForKey:@"text"];
                }
                
                [appointmentRecords addObject:model];
                [model release];
            }
            
        }
        if ([appointmentRecords count]>0&&[_delegate respondsToSelector:@selector(RequestPatientFinished:)]) {
            [self.delegate RequestPatientFinished:self];
        }
        else if([appointmentRecords count]==0&&[_delegate respondsToSelector:@selector(RequestPatientFailed:)]){
            [self.delegate RequestPatientFailed:self];
        }
        return;
    }
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
        if ([dic objectForKey:@"opaId"]!=nil) {
            appRecordModel *model = [[appRecordModel alloc] init];
            model.opaID = [dic objectForKey:@"opaId"];
            model.patientName = [dic objectForKey:@"patientName"];
            model.gender = [dic objectForKey:@"gender"];
            model.birthDate = [dic objectForKey:@"birthDate"];
            model.phone = [dic objectForKey:@"phone"];
            model.IDNumber = [dic objectForKey:@"idNumber"];
            model.doctorName = [dic objectForKey:@"doctorName"];
            model.deptName = [dic objectForKey:@"deptName"];
            model.apptDate = [dic objectForKey:@"apptDate"];
            model.apptTime = [dic objectForKey:@"apptTime"];
            model.ticketNo = [dic objectForKey:@"ticketNo"];
            model.cancelFlag = [dic objectForKey:@"cancelFlag"];
            [appointmentRecords addObject:model];
            [model release];
        }
    }
    
    if ([code integerValue]==0&&[_delegate respondsToSelector:@selector(RequestPatientFinished:)]) {
        [self.delegate RequestPatientFinished:self];
    }
    else if([code integerValue]==1&&[_delegate respondsToSelector:@selector(RequestPatientFailed:)]){
        [self.delegate RequestPatientFailed:self];
    }

}
// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[GetXML alloc] init];
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"opaId",@"patientName",@"gender",@"birthDate",@"phone",@"idNumber",@"deptName",@"doctorName",@"apptDate",@"apptTime",@"ticketNo",@"cancelFlag", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"appointment", nil];
    [xmlParser parseWithData:data];
    return [xmlParser getFinalArray];
}

@end
