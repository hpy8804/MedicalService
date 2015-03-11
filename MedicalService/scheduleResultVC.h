//
//  scheduleResultVC.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-16.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboard;
@class departmentModel;
@class hospitalModel;
@protocol searchListDelegate;
@protocol AppointmentDelegate;
@interface scheduleResultVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    FLActivity *activity;
    // 显示日期label
    __weak IBOutlet UILabel *dateLabel;
    // 显示排版时间段表的View
    IBOutlet UIView *scheduleTimeView;
    // 康复用来填写个人信息的View
    IBOutlet UIView *personalInfoView;
    // 阻止键盘挡住textField的SCrollView
    __weak IBOutlet TPKeyboard *TPScrollView;
    // 江滨预约界面
    IBOutlet UIView *BookView;
    // 注册界面
    IBOutlet UIView *patientRegisterView;
    // 查询标识符界面
    IBOutlet UIView *PatientIDView;
}
// 日期左键
- (IBAction)chooseEarlierDate:(id)sender;

// 选择日期右键
- (IBAction)chooseLaterDate:(id)sender;
#pragma mark - BookView 上的按钮事件
// 预约
- (IBAction)makeAppointment:(id)sender;

// 注册
- (IBAction)registerJiangBin:(id)
sender;

// 标识符
- (IBAction)token:(id)sender;

// 填写注册信息
- (IBAction)fillRegisterInfo:(id)sender;



#pragma mark - personalInfoView 上的按钮事件

// 确定预约
- (IBAction)confirmAppointment:(id)sender;

// 取消
- (IBAction)cancel:(id)sender;

// 查询标识符
- (IBAction)queryPatientID:(id)sender;

// 用来判断是否进入本界面
@property (nonatomic, assign) BOOL isPush;
// 获取预约排班时间段的代理
@property (nonatomic, retain) id<searchListDelegate> delegate;
// 获取排班信息的代理
@property (nonatomic, retain) id<AppointmentDelegate> appointDelegate;
// tag用来记录是江滨集团还是康复集团
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy)NSString *errorMessage;
// 用来记录上一界面所选的是否是专家
@property (nonatomic, assign)BOOL isExpert;

// 用来记录所选的医院信息
@property (nonatomic, copy) hospitalModel *selectedHospital;

// 用来记录所选的科室信息
@property (nonatomic ,copy) departmentModel *selectedDept;

// 用来记录所选的日期
@property (nonatomic, copy) NSDate *selectedDate;

@end
