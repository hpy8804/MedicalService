//
//  cancelAppointment.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-26.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol cancelAppointmentDelegate;
@interface cancelAppointment : NSObject


@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)id<cancelAppointmentDelegate> delegate;
-(id)initCancel;
/**
 *  @brief 江滨集团取消预约
 *
 *  @param opaID:预约编码
 */
-(void)cancelJiangBinAppointmentByOpaId:(NSString *)opaID;
/**
 *  @brief 康复集团取消预约
 *
 *  @param orderStr:预约编码
 */
-(void)cancelKangFUAppointmentByOrderStr:(NSString *)orderStr;
@end

@protocol cancelAppointmentDelegate <NSObject>

@optional
-(void)cancelSucced:(cancelAppointment *)cancelRequest;
-(void)cancelFailed:(cancelAppointment *)cancelRequest;

@end