//
//  deptAppointment.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-16.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface deptAppointmentModel : NSObject

@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSString *appointmentTime;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *ordered;

@end
