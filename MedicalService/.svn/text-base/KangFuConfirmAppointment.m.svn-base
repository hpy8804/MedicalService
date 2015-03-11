//
//  KangFuConfirmAppointment.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-12.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "KangFuConfirmAppointment.h"
#import "confirmModel.h"

@implementation KangFuConfirmAppointment

-(id)initWithScheduleID:(NSString *)scheduleID UserInfo:(NSString *)userInfo
{
    self = [self init];
    if (self) {
        confirmAppointment = [[NSMutableArray alloc] init];
        webservice = [[Webservices alloc] init];
        webservice.delegate = self;
        NSArray *params = [NSArray arrayWithObjects:@"ScheduleID",@"UserInfo", nil];
        NSArray *values = [NSArray arrayWithObjects:scheduleID,userInfo, nil];
        NSString *methodName = @"ConfirmAppointment";
        [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
    }
    return self;
}
-(NSMutableArray *)getConfirmAppointment
{
    return confirmAppointment;
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    NSMutableArray *object = [theWebservice GetResponseArray];
    
    for(NSDictionary *dic in object){
        NSDictionary *value = [dic objectForKey:@"ConfirmAppointmentResult"];
        
            confirmModel *model = [[confirmModel alloc] init];
            model.successful = [[[value objectForKey:@"Successful"] objectAtIndex:0] objectForKey:@"text"];
            model.info = [[[value objectForKey:@"Info"] objectAtIndex:0] objectForKey:@"text"];
            model.reserveCode = [[[value objectForKey:@"ReserveCode"] objectAtIndex:0] objectForKey:@"text"];
            
            [confirmAppointment addObject:model];
            [model release];
        
    }
}
@end
