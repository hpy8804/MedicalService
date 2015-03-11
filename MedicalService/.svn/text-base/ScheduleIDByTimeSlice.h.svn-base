//
//  ScheduleIDByTimeSlice.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-29.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScheduleIDSearchDelegete;

@interface ScheduleIDByTimeSlice : NSObject

@property(nonatomic,assign)id<ScheduleIDSearchDelegete> delegate;
-(id)initSchedule;

-(NSString *)getScheduleID;
/**
 *  @brief 康复医院普通门诊 查询其scheduleID 用于预约
 *  
 *  @param TimeSlice    时间段信息
 *  @param hospitalCode 医院编码
 *  @param deptCode     科室编码
 *  @param scheduleDate 预约日期
 */
-(void)scheduleIDSearchByTimeSlice:(NSString *)TimeSlice HospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode ScheduleDate:(NSString *)scheduleDate;
@end
@protocol ScheduleIDSearchDelegete <NSObject>

@optional
-(void)getScheduleIDSucced:(ScheduleIDByTimeSlice *)schedule;

@end
