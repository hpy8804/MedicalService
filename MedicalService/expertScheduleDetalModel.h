//
//  expertScheduleDetalModel.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-23.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface expertScheduleDetalModel : NSObject
@property(nonatomic, copy)NSString *currentHour;
@property(nonatomic, copy)NSString *scheduleID;
@property(nonatomic, copy)NSString *resourceID;
@property(nonatomic, copy)NSString *scheduleDate;
@property(nonatomic, copy)NSString *sliceStartTime;
@property(nonatomic, copy)NSString *sliceEndTime;
@property(nonatomic, copy)NSString *registNumber;

@end
