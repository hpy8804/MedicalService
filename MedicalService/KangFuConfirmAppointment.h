//
//  KangFuConfirmAppointment.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-12.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KangFuConfirmAppointment : NSObject<WebservicesDelegate>
{
    NSMutableArray *confirmAppointment;
    Webservices *webservice;
}
-(id)initWithScheduleID:(NSString *)scheduleID UserInfo:(NSString *)userInfo;
-(NSMutableArray *)getConfirmAppointment;
@end
