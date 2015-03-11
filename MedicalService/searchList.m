//
//  searchList.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-15.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "searchList.h"

#import "NSString+block.h"

#import "Webservices.h"
#import "GetXML.h"

#import "searchListModel.h"
#import "deptAppointmentModel.h"
#import "expertScheduleInfo.h"
@interface searchList ()<WebservicesDelegate>
{
    Webservices *webservice;
    
    GetXML *xmlParser;
    
    NSMutableArray *KangFuSearchResult;
    
    NSMutableArray *JiangBinSearchResult;
    
    NSMutableArray *expertSearchResult;
    
    NSString *message;
}

@end

@implementation searchList
@synthesize tag;
-(id) initSearch
{
    if (self = [self init]) {
        webservice = [[Webservices alloc] init];
        
        JiangBinSearchResult = [[NSMutableArray alloc] init];
        
        KangFuSearchResult = [[NSMutableArray alloc] init];
        
        expertSearchResult = [[NSMutableArray alloc] init];
    }
    
    
    
    return self;
}
-(NSString *)getMessage
{
    return message;
}
-(NSMutableArray *)getExpertSearchResult
{
    return expertSearchResult;
    
}
-(NSMutableArray *)getKangFuSearchResult
{
    return KangFuSearchResult;
}
-(NSMutableArray *)getJiangBinSearchResult
{
    return JiangBinSearchResult;
}
-(void)searchScheduleByDeparmentWithHospitalCode:(NSString *)hospitalCode deptCode:(NSString *)deptCode Monday:(NSString *)monday Sunday:(NSString *)sunday
{
    // 方法名
    NSString *methodName = @"GetDeptScheduleByDepartment";
    // 参数名
    NSArray *params = [NSArray arrayWithObjects:@"HospitalCode",@"DeptCode",@"MonDay",@"SunDay", nil];
    
    // 参数值
    NSArray *values = [NSArray arrayWithObjects:hospitalCode, deptCode, monday, sunday, nil];
    
    webservice.tag = ordinaryOutpatient;
    
    webservice.delegate = self;
    
    // 请求数据
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)searchExpertScheduleWithHospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode StartDate:(NSString *)startDate
{
    // 方法名
    NSString *methodName = @"GetExpertScheduleInfo";
    // 参数名
    NSArray *params = [NSArray arrayWithObjects:@"HospitalCode",@"DeptCode",@"StartDate", nil];
    
    // 参数值
    NSArray *values = [NSArray arrayWithObjects:hospitalCode, deptCode, startDate,nil];
    
    webservice.tag = expertOutpatient;
    
    webservice.delegate = self;
    
    // 请求数据
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)getSearchListWithHospitalCode:(NSString *)hospitalCode DeptId:(NSString *)deptID WorkDate:(NSString *)workDate
{
    // 方法名
    NSString *methodName = @"getSchList";
    // 参数名
    NSArray *params = [NSArray arrayWithObjects:@"arg0",@"arg1",@"arg4", nil];
    // 参数值
    NSArray *values = [NSArray arrayWithObjects:hospitalCode, deptID, workDate, nil];
    
    webservice.tag = JiangBinTag;
    // 代理
    webservice.delegate = self;
    // 请求数据
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
}
// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlParser = [[GetXML alloc] init];
    
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"schId",@"deptId",@"deptName",@"doctorId",@"doctorName",@"ticketTypeId",@"ticketTypeName",@"workDate",@"dateSlotName",@"beginTime",@"endTime",@"apptCount", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"schedule", nil];
    
    
    [xmlParser parseWithData:data];
    
    return [xmlParser getFinalArray];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    if (theWebservice.tag==JiangBinTag) {
        
        // 获取江滨医院数据
        NSInteger code = 3;
        NSString *responseString = [theWebservice GetResponseString];
        
        responseString = [NSString cutForJiangBin:responseString];
        
        NSMutableArray *array = [self getXMLString:responseString];
        
        for(NSDictionary *dic in array){
            
            if ([dic objectForKey:@"code"]!=nil) {
                
                code = [[dic objectForKey:@"code"] integerValue];
            }
            if ([dic objectForKey:@"msg"]!=nil) {
                message = [[NSString alloc] initWithString:[dic objectForKey:@"msg"]];
            }
           
            if ([dic objectForKey:@"schId"]!=nil) {
                
                searchListModel *model = [[searchListModel alloc] init];
                
                model.schId             = [dic objectForKey:@"schId"];
                
                model.deptId            = [dic objectForKey:@"deptId"];
                
                model.deptName          = [dic objectForKey:@"deptName"];
                
                model.doctorId          = [dic objectForKey:@"doctorId"];
                
                model.doctorName        = [dic objectForKey:@"doctorName"];
                
                model.ticketTypeId      = [dic objectForKey:@"ticketTypeId"];
                
                model.ticketTypeName    = [dic objectForKey:@"ticketTypeName"];
                
                model.workDate          = [dic objectForKey:@"workDate"];
                
                model.dateSlotName      = [dic objectForKey:@"dateSlotName"];
                
                model.beginTime         = [dic objectForKey:@"beginTime"];
                
                model.endTime           = [dic objectForKey:@"endTime"];
                
                model.appCount          = [dic objectForKey:@"apptCount"];
                
                if (model.workDate!=nil) {
                    [JiangBinSearchResult addObject:model];
                }
                [model release];
            }
        }
        if (code==1&&[_delegate respondsToSelector:@selector(JiangBinMessageFailed:)]) {
            [self.delegate JiangBinMessageFailed:self];
            return;
        }
    }
    else if (theWebservice.tag==ordinaryOutpatient){
        // 获取康复医院数据
        NSMutableArray *responseArray = [theWebservice GetResponseArray];
        for(NSDictionary *dic in responseArray){
            
            NSArray *dept = [dic objectForKey:@"Schedule"];
            for(NSDictionary *value in dept){
                deptAppointmentModel *model = [[deptAppointmentModel alloc] init];
                model.appointmentDate = [[[value objectForKey:@"AppointmentDate"] objectAtIndex:0] objectForKey:@"text"];
                model.appointmentTime = [[[value objectForKey:@"AppointmentTime"] objectAtIndex:0] objectForKey:@"text"];
                model.total = [[[value objectForKey:@"Total"] objectAtIndex:0] objectForKey:@"text"];
                model.ordered = [[[value objectForKey:@"Ordered"] objectAtIndex:0] objectForKey:@"text"];
                
                if (model.appointmentDate!=nil) {
                    
                    [KangFuSearchResult addObject:model];
                    
                }
                [model release];
                
            }
            
        }

    }
    else if(theWebservice.tag==expertOutpatient){
        NSMutableArray *responseArray = [theWebservice GetResponseArray];
        
        for(NSDictionary *dic in responseArray){
            
            NSArray *resource = [dic objectForKey:@"Resource"];
            for(NSDictionary *value in resource){
                expertScheduleInfo *model = [[expertScheduleInfo alloc] init];
                model.hour = [[[value objectForKey:@"Hour"] objectAtIndex:0] objectForKey:@"text"];
                model.resourceID = [[[value objectForKey:@"ResourceID"] objectAtIndex:0] objectForKey:@"text"];
                NSString *date = [[[value objectForKey:@"ScheduleDate"] objectAtIndex:0] objectForKey:@"text"];
                NSArray *array = [date componentsSeparatedByString:@" "];
            
                model.scheduleDate = [array objectAtIndex:0];
                model.count = [[[value objectForKey:@"count"] objectAtIndex:0] objectForKey:@"text"];
                
                if (model.count!=nil) {
                    
                    [expertSearchResult addObject:model];
                    
                }
                [model release];
            }
        }
    }
    if ([_delegate respondsToSelector:@selector(getSearchLishFinished:)]) {
        [self.delegate getSearchLishFinished:self];
    }
    
    
}
-(void)dealloc
{
    [super dealloc];
    
    [xmlParser release];
    
    webservice.delegate = nil;
    
    [webservice release];
    
    [KangFuSearchResult release];
    
    [JiangBinSearchResult release];
    
}
@end
