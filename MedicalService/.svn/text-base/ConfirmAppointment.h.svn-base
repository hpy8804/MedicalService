//
//  KangFuConfirmAppointment.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-12.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol confirmDelegate;
@interface ConfirmAppointment : NSObject<WebservicesDelegate>
{
    NSMutableArray *confirmAppointment;
    Webservices *webservice;
}
@property(nonatomic, assign)id<confirmDelegate> delegate;
@property(nonatomic, assign)NSInteger tag;
// 初始化
-(id)initAppoint;

// 获取预约失败的原因
-(NSString *)getFailMessage;

// 获取预约编号
-(NSString *)getAppointmentID;

/**
 *  @brief 康复集团确认预约接口
 *
 *  @param scheduleID:预约排班编码号
 *  @param UserInfo:用户信息，传值格式为
 *  <?xml version=\"1.0\" encoding=\"UTF-8\"?>"
     "<UserInfo>
        <Name>?</Name>
        <Phone>?</Phone>
        <Birthday>?</Birthday>
        <IDNum>?</IDNum>
        <Gender>?</Gender>
        <CardType>?</CardType>
        <CardNo>?</CardNo>
        <SecondPhone>?</SecondPhone>
        <Source>5</Source>"
     </UserInfo>";
 *
 *  返回预约编码，请求成功后去获取
 */
-(void)confirmWithScheduleID:(NSString *)scheduleID UserInfo:(NSString *)userInfo;
/**
 *  @brief 江滨集团确认预约接口
 *
 *  @param schID:预约排班编码号
 *  @param ticketId:预约号码ID，为空时系统自动分配
 *  @param patientId:患者唯一标识，不可为空
 *  
 *  返回预约编码，请求成功后去获取
 */
-(void)confirmWithSchID:(NSString *)schID TicketID:(NSString *)ticketId PatientID:(NSString *)patientId;

-(NSMutableArray *)getConfirmAppointment;
@end

@protocol confirmDelegate <NSObject>

@optional
-(void)getConfirmSuccess:(ConfirmAppointment *)theConfirmRequest;
-(void)getConfirmFailed:(ConfirmAppointment *)theConfirmRequest;

@end
