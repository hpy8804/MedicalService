//
//  regPatientInfo.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-22.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol regDelegate;

@interface regPatientInfo : NSObject

@property(nonatomic, retain)id<regDelegate> delegate;

@property(nonatomic, assign)NSInteger tag;


-(id)initReg;
-(NSString *)getMessage;
/**
 *  @brief  获取病人patientId
 */
-(NSString *)getPatientId;

/**
 *  @brief 江滨集团病人注册，获取到patientId
 *
 *  @param hospitalCode 医院编码
 *  @param patientName  病人姓名
 *  @param gender       性别(1男2女)
 *  @param IdNumber     身份证号
 *  @param phone        电话号码
 *
 */
-(void)regPatientInfoWithHospitalCode:(NSString *)hospitalCode PatientName:(NSString *)patientName Birthday:(NSString *)brithday Gender:(NSString *)gender IDNumber:(NSString *)IdNumber Phone:(NSString *)phone;
@end

@protocol regDelegate <NSObject>

@optional

-(void)getPatientInfoFinished:(regPatientInfo *)theReg;
-(void)registerFailed:(regPatientInfo *)theReg;

@end
