//
//  hospitalAppointVC.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class scheduleResultVC;

@protocol AppointmentDelegate;
@interface hospitalAppointVC : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate>
{
    FLActivity *activity;
    
    NSArray *hospitalInfo;
    NSArray *departmentInfo;
    NSArray *expertDepartmentInfo;
    
    
    __weak IBOutlet UIImageView *ordinaryImageView;
    
    __weak IBOutlet UIImageView *expertImageView;
 // 普通门诊
    __weak IBOutlet UIButton *ordinary;
    // 专家门诊
    __weak IBOutlet UIButton *expert;
    // 医院Label
    __weak IBOutlet UILabel *hospitalLabel;
    // 科室label
    __weak IBOutlet UILabel *categaryLabel;
    // 日期Label
    __weak IBOutlet UILabel *dateLabel;
}
@property (nonatomic, retain)NSDate *selectedDate;
@property (nonatomic, assign)NSInteger team;
@property (nonatomic, assign)NSInteger outpatient;
// 选择专家或是普通门诊
- (IBAction)chooseOutpatient:(id)sender;
// 选择医院
- (IBAction)chooseHospital:(id)sender;
// 选择科室
- (IBAction)chooseRoom:(id)sender;
// 选择日期
- (IBAction)chooseDate:(id)sender;
// 提交预约
- (IBAction)subimitAppointment:(id)sender;
@end

@protocol AppointmentDelegate <NSObject>

@optional

-(void)appointmentResult:(scheduleResultVC *)theSchedule;
-(void)AppointJiangBinFailed:(scheduleResultVC *)theSchedule;

@end
