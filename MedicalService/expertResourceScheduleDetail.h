//
//  expertResourceScheduleDetail.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-22.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class expertInfoModel;
@protocol expertResourceDelegate;
@interface expertResourceScheduleDetail : NSObject

@property(nonatomic, retain)id<expertResourceDelegate> delegate;

-(id)initExpert;
-(NSMutableArray *)expertSchedleArray;

-(expertInfoModel *)getExpert;
/**
 *  @brief 通过resourceID获取专家的时间表
 *
 *  @param resourceID   获取到的专家的资源代码
 *  @param currentDate  当前日期 格式为YYYY-MM-dd
 *  @param isAm         上午(0)还是下午(1)
 */
-(void)requestExpertScheduleByResourceID:(NSString *)resourceID CurrentDate:(NSString *)currentDate IsAm:(NSString *)isAm;
/**
 *  @brief 通过resourceID获取专家的信息，如姓名，专家编号等
 *  
 *  @param  resourceID 专家资源代码
 */
-(void)GetExperInfoByResourceID:(NSString *)resourceID;
@end

@protocol expertResourceDelegate <NSObject>

@optional
-(void)getExpertFinished:(expertResourceScheduleDetail *)theExpert;
-(void)getScheduleDetailFinished:(expertResourceScheduleDetail *)theExpert;
@end
