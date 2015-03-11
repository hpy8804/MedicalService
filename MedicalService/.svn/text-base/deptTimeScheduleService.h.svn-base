//
//  deptTimeScheduleService.h
//  MedicalService
//
//  请求webservice 获取医院科室预约各个时间段的信息
//
//  Created by 张琼芳 on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol deptTimeScheduleDelegate;

@interface deptTimeScheduleService : NSObject

@property (nonatomic, retain)id<deptTimeScheduleDelegate> delegate;

@property (nonatomic, assign)NSUInteger tag;

-(NSMutableArray *)getDeptScheduleResult;

-(void)requestJiangBinTimeScheduleWithSchId:(NSString *)schId;


-(void)requestKangFuDeptTimeScheduleWithHospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode ScheduleDate:(NSString *)date Hour:(NSString *)hour;


@end



@protocol deptTimeScheduleDelegate <NSObject>

@optional

-(void)getDeptTimeScheduleFinished:(deptTimeScheduleService *)timeSchedule;

@end




