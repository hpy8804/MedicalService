//
//  getPatientInfo.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol patientInfoDelegate;

@interface getPatientInfo : NSObject


@property(nonatomic, retain)id<patientInfoDelegate> delegate;
// 初始化
-(id)initPatient;
// 返回错误信息
-(NSString *)getMessage;
// 返回病人信息
-(NSMutableArray *)getPatientInfoArray;
/**
 *  @brief 获取病人的信息
 *
 *  @param hospitalCode:医院编码
 *  @param patientName:病人姓名
 *  @param IDNumber:身份证号
 *  @param phone:电话号码
 *  @param cardNumber:健康卡号,选填,没有时传值为nil
 */
-(void)getpatientInfoByHospitalCode:(NSString *)hospitalCode PatientName:(NSString *)patientName IDNumber:(NSString *)IdNumber Phone:(NSString *)phone CardNumber:(NSString *)cardNumber;
@end

@protocol patientInfoDelegate <NSObject>

@optional
-(void)getPatientInfoSuccess:(getPatientInfo *)thePatientInfo;
-(void)getPatientInfoFailed:(getPatientInfo *)thePatientInfo;

@end
