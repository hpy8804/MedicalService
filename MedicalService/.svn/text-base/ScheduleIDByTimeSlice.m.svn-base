//
//  ScheduleIDByTimeSlice.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-29.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "ScheduleIDByTimeSlice.h"

@interface ScheduleIDByTimeSlice ()<WebservicesDelegate>
{
    Webservices *webservice;
    NSString *ScheduleID;
}

@end

@implementation ScheduleIDByTimeSlice
-(id)initSchedule
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        ScheduleID = [[NSString alloc] init];
    }
    return self;
}
-(NSString *)getScheduleID
{
    return ScheduleID;
}
-(void)scheduleIDSearchByTimeSlice:(NSString *)TimeSlice HospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode ScheduleDate:(NSString *)scheduleDate
{
    webservice.delegate = self;
    webservice.tag = KangFuTag;
    NSString *methodName = @"GetScheduleIDByTimeSlice";
    NSArray *params = [NSArray arrayWithObjects:@"TimeSlice", @"HospitalCode", @"DeptCode", @"ScheduleDate", nil];
    NSArray *values = [NSArray arrayWithObjects:TimeSlice,hospitalCode,deptCode, scheduleDate, nil];
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    NSMutableArray *array = [theWebservice GetResponseArray];
   
    if ([array count]>0) {
        NSDictionary *dic = [array objectAtIndex:0];
        NSArray *scheduleDetail = [dic objectForKey:@"ScheduleDetail"];
        ScheduleID = [[[[scheduleDetail objectAtIndex:0] objectForKey:@"ScheduleID"] objectAtIndex:0] objectForKey:@"text"];
    }
    if (ScheduleID!=nil && [_delegate respondsToSelector:@selector(getScheduleIDSucced:)]) {
        [self.delegate getScheduleIDSucced:self];
    }
}
@end
