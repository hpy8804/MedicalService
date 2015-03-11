//
//  KangFuConfirmAppointment.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-12.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "ConfirmAppointment.h"
#import "confirmModel.h"

#import "NSString+block.h"
#import "GetXML.h"
@interface ConfirmAppointment (){
    NSString *message;
    NSString *appointmentId;
    GetXML *xmlParser;
}

@end

@implementation ConfirmAppointment

-(id)initAppoint
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        confirmAppointment = [[NSMutableArray alloc] init];
    }
    return self;
    
}
-(NSString *)getAppointmentID
{
    return appointmentId;
}
-(NSString *)getFailMessage
{
    return message;
}
-(NSMutableArray *)getConfirmAppointment
{
    return confirmAppointment;
}
-(void)confirmWithScheduleID:(NSString *)scheduleID UserInfo:(NSString *)userInfo
{
    
    webservice.tag = KangFuTag;
    
    webservice.delegate = self;
    NSArray *params = [NSArray arrayWithObjects:@"ScheduleID",@"UserInfo", nil];
    NSArray *values = [NSArray arrayWithObjects:scheduleID,userInfo, nil];
    NSString *methodName = @"ConfirmAppointment";
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
    
}
-(void)confirmWithSchID:(NSString *)schID TicketID:(NSString *)ticketId PatientID:(NSString *)patientId
{
    webservice.tag = JiangBinTag;
    webservice.delegate = self;
    NSString *methodName = @"bookingRegistration";
    NSArray *params = [NSArray arrayWithObjects:@"arg0",@"arg1",@"arg2", nil];
    NSArray *values = [NSArray arrayWithObjects:schID,ticketId,patientId, nil];
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    if (theWebservice.tag==KangFuTag) {
        
        NSMutableArray *object = [theWebservice GetResponseArray];
       
        confirmModel *model = [[confirmModel alloc] init];
        message = [[NSString alloc] init];

        for(NSDictionary *dic in object){
            
            if ([[dic objectForKey:@"Successful"] isKindOfClass:[NSArray class]]) {
                model.successful = [[[dic objectForKey:@"Successful"] objectAtIndex:0] objectForKey:@"text"];
                continue;
            }
            else if([dic objectForKey:@"Successful"]!=nil){
                model.successful = [dic objectForKey:@"Successful"];
                continue;
            }
            if ([[dic objectForKey:@"Info"] isKindOfClass:[NSArray class]]) {
                model.info = [[[dic objectForKey:@"Info"] objectAtIndex:0] objectForKey:@"text"];
                continue;
            }
            else if([dic objectForKey:@"Info"]!=nil){
                model.info =[dic objectForKey:@"Info"];
                continue;
            }
            if ([[dic objectForKey:@"ReserveCode"] isKindOfClass:[NSArray class]]) {
                model.reserveCode = [[[dic objectForKey:@"ReserveCode"] objectAtIndex:0] objectForKey:@"text"];
                continue;
            }
            else if([dic objectForKey:@"ReserveCode"]!=nil){
                model.reserveCode = [dic objectForKey:@"ReserveCode"];
                continue;
            }
            
            
        }
        appointmentId = model.reserveCode;
        message = model.info;
        [confirmAppointment addObject:model];
        if ([model.successful isEqualToString:@"0"]&&[_delegate respondsToSelector:@selector(getConfirmFailed:)]) {
            [self.delegate getConfirmFailed:self];
        }
        else if ([model.successful isEqualToString:@"1"]&&[_delegate respondsToSelector:@selector(getConfirmSuccess:)]){
            [self.delegate getConfirmSuccess:self];
        }
        [model release];
        
    }
    else{
    
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
            if ([dic objectForKey:@"opaId"]!=nil){
                appointmentId = [dic objectForKey:@"opaId"];
            }
            
        }
        if ([code integerValue] == 0&&[_delegate respondsToSelector:@selector(getConfirmSuccess:)]) {
            [self.delegate getConfirmSuccess:self];
        }
        else if([code integerValue]==1&&[_delegate respondsToSelector:@selector(getConfirmFailed:)]){
            [self.delegate getConfirmFailed:self];
        }
    }
}

// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[GetXML alloc] init];
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"opaId", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"opaId", nil];
    [xmlParser parseWithData:data];
    return [xmlParser getFinalArray];
}

@end
