//
//  expertResourceScheduleDetail.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-22.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "expertResourceScheduleDetail.h"
#import "expertInfoModel.h"
#import "expertScheduleDetalModel.h"
enum{
    expertInfoTag = 10,
    expertScheduleTag = 20
};
@interface expertResourceScheduleDetail ()<WebservicesDelegate>{
    Webservices *webservice;
    NSMutableArray *expertScheduleDetail;
    expertInfoModel *expertInfo;
}

@end

@implementation expertResourceScheduleDetail

-(NSMutableArray *)expertSchedleArray
{
    return expertScheduleDetail;
}

-(expertInfoModel *)getExpert
{
    return expertInfo;
}
-(id)initExpert
{
    self =[self init];
    webservice = [[Webservices alloc] init];
    expertInfo = [[expertInfoModel alloc] init];
    expertScheduleDetail = [[NSMutableArray alloc] init];
    
    
    return self;
}
-(void)requestExpertScheduleByResourceID:(NSString *)resourceID CurrentDate:(NSString *)currentDate IsAm:(NSString *)isAm
{
    webservice.delegate = self;
    webservice.tag = expertScheduleTag;
    NSString *methodName = @"GetExpertResourceScheduleDetail";
    NSArray *params = [NSArray arrayWithObjects:@"ResourceID",@"CurrentDate",@"IsAm", nil];
    NSArray *values = [NSArray arrayWithObjects:resourceID,currentDate,isAm, nil];
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}

-(void)GetExperInfoByResourceID:(NSString *)resourceID
{
    webservice.delegate = self;
    webservice.tag = expertInfoTag;
    NSString *methodName = @"GetResourceByResourceID";
    NSArray *params = [NSArray arrayWithObject:@"ResourceIDstr"];
    NSArray *values = [NSArray arrayWithObject:resourceID];
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    
    NSMutableArray *array = [theWebservice GetResponseArray];
    // 获取专家信息
    if (theWebservice.tag == expertInfoTag) {
        for(NSDictionary *object in array){
            NSArray *resource = [object objectForKey:@"Resource"];
            for(NSDictionary *dic in resource){
        
            expertInfo.resourceID = [[[dic objectForKey:@"ResourceID"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.hospitalCode = [[[dic objectForKey:@"HospitalCode"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.appointmetType = [[[dic objectForKey:@"AppointmentType"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.deptCode = [[[dic objectForKey:@"DeptCode"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.deptName = [[[dic objectForKey:@"DeptName"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.expertCode = [[[dic objectForKey:@"ExpertCode"] objectAtIndex:0] objectForKey:@"text"];
            expertInfo.expertName = [[[dic objectForKey:@"ExpertName"] objectAtIndex:0] objectForKey:@"text"];
            
            }
        }
        if ([_delegate respondsToSelector:@selector(getExpertFinished:)]) {
            [self.delegate getExpertFinished:self];
        }

    }
    // 获取专家时间表
    else if(theWebservice.tag == expertScheduleTag){
        for(NSDictionary *object in array){
            NSArray *resource = [object objectForKey:@"ScheduleDetail"];
            for(NSDictionary *dic in resource){
                expertScheduleDetalModel *detail = [[expertScheduleDetalModel alloc] init];
                detail.currentHour = [[[dic objectForKey:@"CurrentHour"] objectAtIndex:0] objectForKey:@"text"];
                detail.scheduleID = [[[dic objectForKey:@"ScheduleID"]objectAtIndex:0] objectForKey:@"text"];
                detail.resourceID = [[[dic objectForKey:@"ResourceID"]objectAtIndex:0] objectForKey:@"text"];
                detail.scheduleDate = [[[dic objectForKey:@"ScheduleDate"]objectAtIndex:0] objectForKey:@"text"];
                detail.sliceStartTime = [[[dic objectForKey:@"SliceStartTime"]objectAtIndex:0] objectForKey:@"text"];
                detail.sliceEndTime = [[[dic objectForKey:@"SliceEndTime"]objectAtIndex:0] objectForKey:@"text"];
                detail.registNumber = [[[dic objectForKey:@"RegistNumber"]objectAtIndex:0] objectForKey:@"text"];
                [expertScheduleDetail addObject:detail];
                [detail release];
            }
        }
        if ([expertScheduleDetail count]>0&&[_delegate respondsToSelector:@selector(getScheduleDetailFinished:)]) {
            [self.delegate getScheduleDetailFinished:self];
        }
    }
    
}
-(void)dealloc{
    [super dealloc];
    webservice.delegate = nil;
    [webservice release];
    
}
@end
