//
//  deptTimeScheduleService.m
//  MedicalService
//
//  请求webservice 获取医院科室预约各个时间段的信息
//
//  Created by 张琼芳 on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "deptTimeScheduleService.h"
#import "deptTimeModel.h"
#import "ticketListModel.h"
#import "GetXML.h"
#import "NSString+block.h"
@interface deptTimeScheduleService ()<WebservicesDelegate>
{
    GetXML *xmlParser;
    Webservices *webservice;
    NSMutableArray *timeScheduleResult;
}

@end

@implementation deptTimeScheduleService

@synthesize delegate,tag;
-(id)init
{
    if (self) {
        
    }
    
    
    return self;
}
-(void)dealloc
{
    [super dealloc];
    webservice.delegate = nil;
    [webservice release];
}
-(NSMutableArray *)getDeptScheduleResult
{
    return timeScheduleResult;
}
// 请求江滨集团数据
-(void)requestJiangBinTimeScheduleWithSchId:(NSString *)schId
{
    webservice = [[Webservices alloc] init];
    webservice.tag = JiangBinTag;
    // 代理
    webservice.delegate = self;
    // 方法名
    NSString *methodName = @"getTicketList";
    // 参数
    NSArray *params = [NSArray arrayWithObject: @"arg0"];
    // 值
    NSArray *values = [NSArray arrayWithObject:schId];
    // 开始请求
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
}
// 请求康复集团数据
-(void)requestKangFuDeptTimeScheduleWithHospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode ScheduleDate:(NSString *)date Hour:(NSString *)hour
{
    webservice = [[Webservices alloc] init];
    webservice.tag = KangFuTag;
    // 代理
    webservice.delegate = self;
    // 方法名
    NSString *methodName = @"GetDeptTimeSliceScheduleByHour";
    // 参数名
    NSArray *params = [NSArray arrayWithObjects:@"HospitalCode",@"DeptCode",@"ScheduleDate",@"hour", nil];
    // 参数值
    NSArray *values = [NSArray arrayWithObjects:hospitalCode,deptCode,date,hour, nil];
    // 请求
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
    
}
// 请求成功回调方法
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    timeScheduleResult = [[NSMutableArray alloc] init];
    if (theWebservice.tag == KangFuTag) {
        // 康复集团
        NSMutableArray *array = [theWebservice GetResponseArray];
        for(NSDictionary *dic in array ){
            
            // 根据key值字段一一存储数据到数组
            NSArray *timeSlice = [dic objectForKey:@"TimeSlice"];
            
            for(NSDictionary *result in timeSlice)
            {
                // 用自定义类获取
                deptTimeModel *model = [[deptTimeModel alloc] init];
                
                if ([[result objectForKey:@"Ordered"] isKindOfClass:[NSArray class]])
                {
                    model.ordered = [[[result objectForKey:@"Ordered"] objectAtIndex:0] objectForKey:@"text"];      
                }
                else
                {
                    model.ordered = 0;
                }
                model.sliceStartTime = [[[result objectForKey:@"SliceStartTime"] objectAtIndex:0] objectForKey:@"text"];
                
                model.maxNumber = [[[result objectForKey:@"maxNumber"] objectAtIndex:0]objectForKey:@"text"];
                
                model.minNumber = [[[result objectForKey:@"minNumber"] objectAtIndex:0]objectForKey:@"text"];
                
                model.total = [[[result objectForKey:@"total"] objectAtIndex:0]objectForKey:@"text"];
                
                [timeScheduleResult addObject:model];
                
                [model release];
            }
        }
    }
    else if (theWebservice.tag == JiangBinTag){
        // 江滨
        NSString *responseString = [theWebservice GetResponseString];
        
        responseString = [NSString cutForJiangBin:responseString];
        
        NSMutableArray *array = [self getXMLString:responseString];
        
        
        for(NSDictionary *dic in array){
            
            if ([dic objectForKey:@"ticketId"]!=nil) {
                
                ticketListModel *model = [[ticketListModel alloc] init];
                
                model.ticketId = [dic objectForKey:@"ticketId"];
                
                model.tickerNo = [dic objectForKey:@"ticketNo"];
                
                model.apptTime = [dic objectForKey:@"apptTime"];
                
                [timeScheduleResult addObject:model];
                
                [model release];
            }
        }
        
    }
    // 设置代理
    if ([delegate respondsToSelector:@selector(getDeptTimeScheduleFinished:)]) {
        [self.delegate getDeptTimeScheduleFinished:self];
    }
    
}
// 解析XML
-(NSMutableArray *)getXMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlParser = [[GetXML alloc] init];
    
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code",@"msg",@"ticketId",@"deptId",@"apptTime", nil];
    
    xmlParser.keyElements = [NSArray arrayWithObjects:@"code",@"msg",@"ticket", nil];
    
    
    [xmlParser parseWithData:data];
    
    return [xmlParser getFinalArray];
}
@end
