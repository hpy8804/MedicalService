//
//  queryAppRecord.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol queryRecordDelegate;
@interface queryAppRecord : NSObject
@property(nonatomic,retain)id<queryRecordDelegate> delegate;

-(id)initRecord;


-(NSString *)getMessage;
-(NSMutableArray *)getRecordArray;
/**
 *  @brief 查询江滨集团预约的情况
 *  
 *  @param phoneNumber:手机号码
 *  @param IDNumber:身份证号
 */
-(void)queryRecordByPhoneNumber:(NSString *)phoneNumber OrIdNumber:(NSString *)IDNumber;
/**
 *  @brief 查询康复集团预约的情况
 *
 *  @param TelePhone:手机号码
 *  @param IDNumber:身份证号
 */
-(void)searchAppointmentByPatientName:(NSString *)patientName Telephone:(NSString *)telephone IDNumber:(NSString *)idNumber;
@end

@protocol queryRecordDelegate <NSObject>

@optional
-(void)RequestPatientFinished:(queryAppRecord *)record;
-(void)RequestPatientFailed:(queryAppRecord *)record;
@end

