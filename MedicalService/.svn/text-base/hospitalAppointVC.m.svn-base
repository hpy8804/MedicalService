//
//  hospitalAppointVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "hospitalAppointVC.h"

#import "FLActivity.h"
#import "popAlertView.h"

#import "getHospital.h"
#import "hospitalModel.h"

#import "getDepartmentByHospital.h"
#import "departmentModel.h"

#import "searchList.h"

#import "scheduleResultVC.h"

@interface hospitalAppointVC ()<getHospitalDelegate,getDepartmentDelegate,AppointmentDelegate>
{
    getHospital *hospital;
    getDepartmentByHospital *getDepartment;
    hospitalModel *selectedHospital;
    departmentModel *selectedDepartment;
    
    UIView *dateView;
    UIDatePicker *datePicker;
    
    
    NSMutableArray *ordinaryDepartment;
    NSMutableArray *expertDepartment;
}
@property (nonatomic, strong) UIView *grayView;
@end

@implementation hospitalAppointVC
@synthesize team,selectedDate;
#pragma - mark life cycle 生命周期方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activity = [[FLActivity alloc] init];
        
        selectedDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[NSDate date]];
        
        ordinaryDepartment = [[NSMutableArray alloc] init];
        
        expertDepartment = [[NSMutableArray alloc] init];
        
        selectedHospital = [[hospitalModel alloc] init];
        
        selectedDepartment = [[departmentModel alloc] init];
        
        self.outpatient = ordinaryOutpatient;
        
        
        self.title = @"预约服务";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 获取医院和相应科室信息
    [self getHospital];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    dateLabel.text = [[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10];

    [dateFormatter release];
    
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

 
    
}
-(void)dealloc
{
    ordinary=nil;
    [ordinary release];
    
    expert = nil;
    [expert release];
    
    hospitalLabel = nil;
    [hospitalLabel release];
    
    categaryLabel = nil;
    [categaryLabel release];
    
    dateLabel = nil;
    [dateLabel release];
    
    hospitalInfo = nil;
    [hospitalInfo release];
    
    departmentInfo = nil;
    [departmentInfo release];
    
    expertDepartmentInfo = nil;
    [expertDepartmentInfo release];
    
    [hospital release];
    
    [getDepartment release];
    [super dealloc];
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 网络请求数据 webservice
#pragma - mark 获取医院信息
-(void)getHospital
{
    hospitalInfo = [[NSArray alloc] init];
    
    [activity startActivity:self.view parentViewDisabled:YES];
    if (self.team==KangFuTag) {
        // 康复
        hospital = [[getHospital alloc] initForKangFu];
        
        hospital.delegate = self;
        hospital.tag = KangFuTag;
        
        hospital.parentView = self.view;
        
    }
    else if(self.team == JiangBinTag){
        
        // 江滨
        hospital = [[getHospital alloc] initForJiangBin];
        hospital.tag = JiangBinTag;
        hospital.delegate = self;
        
        
        
    }
    
   
}
#pragma - mark 获取医院回调方法
-(void)getValueFinished:(getHospital *)ahospital
{
    if (hospital.tag == JiangBinTag) {
        hospitalInfo = [ahospital JiangBinHospitals];
    }
    else if(hospital.tag == KangFuTag){
        hospitalInfo = [ahospital KangFuHospitals];
    }
    if ([hospitalInfo count]>0) {
        
        // 设置医院label内容
        selectedHospital = [hospitalInfo objectAtIndex:0];
        
        hospitalLabel.text = selectedHospital.hospitalName;
        
        [self getDepartment];
    }
    
}
#pragma - mark 获取科室信息
-(void)getDepartment
{
    departmentInfo = [[NSArray alloc] init];
    
    if (team == KangFuTag) {
        // 康复集团
        getDepartment = [[getDepartmentByHospital alloc] initKangFuWithValue:selectedHospital.hospitalCode];
        
        getDepartment.tag = KangFuTag;
        
    }
    else if(team == JiangBinTag){
        // 江滨集团
        getDepartment = [[getDepartmentByHospital alloc] initJiangBinWithValue:selectedHospital.hospitalCode];
        
        getDepartment.tag = JiangBinTag;
        
        
    }
    getDepartment.delegate = self;
    
}
// 获取科室成功回调方法
-(void)getDepartmentFinished:(getDepartmentByHospital *)department
{
    if (department.tag==KangFuTag) {
        #pragma - mark 获取康复医院的科室信息
        departmentInfo = [department getKangFuDepartment];
        
        // 区分为普通门诊和专家门诊
        
        [ordinaryDepartment removeAllObjects];
        [expertDepartment removeAllObjects];
        for(departmentModel *model in departmentInfo){
            
            if ([model.DeptType isEqualToString:@"1"]) {
                // 普通门诊
                [ordinaryDepartment addObject:model];
            }
            else if([model.DeptType isEqualToString:@"2"]){
                // 专家门诊
                [expertDepartment addObject:model];
            }
        }
        
        // 设置科室label内容
        if (self.outpatient==ordinaryOutpatient) {
            // 普通门诊
            if ([ordinaryDepartment count]>0) {
                selectedDepartment = [ordinaryDepartment objectAtIndex:0];
                categaryLabel.text = selectedDepartment.DepartmentName;
            }
            else{
                [self.view showToast:@"未获取到相关科室信息" withDuration:1];
            }
        }
        else if (self.outpatient==expertOutpatient) {
            // 专家门诊
            if ([expertDepartment count]>0) {
                selectedDepartment = [expertDepartment objectAtIndex:0];
                categaryLabel.text = selectedDepartment.DepartmentName;
            }
            else{
                [self.view showToast:@"未获取到相关科室信息" withDuration:1];
            }
        }
    }
    else if(department.tag == JiangBinTag){
        
        #pragma - mark 获取江滨集团的科室信息
        
        departmentInfo = [department getJiangBinDepartment];
        
        selectedDepartment = [departmentInfo objectAtIndex:0];
        
        categaryLabel.text = selectedDepartment.DepartmentName;
    }
    
    
    [activity stopActivity];
    
}
#pragma mark - 代理方法
#pragma - mark Alert Delegate

-(void)alertView:(popAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else{
        // 获取选择的时间
        self.selectedDate =[NSDate dateWithTimeInterval:0 sinceDate: alertView.datePicker.date];
        NSString *date = [[NSString stringWithFormat:@"%@",alertView.datePicker.date] substringToIndex:10];
        
        if ([alertView.datePicker.date compare:[[NSDate date] dateByAddingTimeInterval:-60]]==NSOrderedAscending) {
            // 如果选择时间比当前时间晚，则将时间改成当前时间
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            dateLabel.text = [[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10];
            [dateFormatter release];
            
            
            
                        
            [self.view showToast:@"不可预约昨天及以前的时间" withDuration:1.5];

        }
        else
        {
            dateLabel.text = date;
            
        }
    }
}
#pragma - mark action sheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    if (actionSheet.tag == hospitalAcionTag) {
        // 选择医院的actionSheet
        
        selectedHospital = [hospitalInfo objectAtIndex:buttonIndex-1];
        
        hospitalLabel.text = selectedHospital.hospitalName;
        // 选择医院后获取对应医院的科室信息
        [self getDepartment];
        
    }
    else if(actionSheet.tag == departmentActionTag)
    {
        // 选择科室的actionSheet
        if (self.team==KangFuTag) {
            if (self.outpatient==ordinaryOutpatient) {
                // 普通门诊的科室
                selectedDepartment = [ordinaryDepartment objectAtIndex:buttonIndex-1];
                
            }
            else if(self.outpatient == expertOutpatient){
                // 专家门诊的科室
                selectedDepartment = [expertDepartment objectAtIndex:buttonIndex-1];
            }

        }
        else{
            selectedDepartment = [departmentInfo objectAtIndex:buttonIndex-1];
        }
        categaryLabel.text = selectedDepartment.DepartmentName;
        
    }
    
}

#pragma  mark - 按钮事件
//选择普通门诊还是专家门诊
- (IBAction)chooseOutpatient:(id)sender {
    
    if (sender == ordinary) {
        #pragma - mark 选择普通门诊
        
        [ordinaryImageView setImage:[UIImage imageNamed:@"radio_pressed"]];
        [expertImageView setImage:[UIImage imageNamed:@"radio_unpressed"]];
        
        self.outpatient = ordinaryOutpatient;
        
        // 设置科室的内容为普通门诊内容
        if (self.team == KangFuTag) {
            selectedDepartment = [ordinaryDepartment objectAtIndex:0];

        }
        else{
            selectedDepartment = [departmentInfo objectAtIndex:0];
        }
        categaryLabel.text = selectedDepartment.DepartmentName;
    }
    else if(sender == expert){
        #pragma - mark 选择专家门诊
        [ordinaryImageView setImage:[UIImage imageNamed:@"radio_unpressed"]];
        [expertImageView setImage:[UIImage imageNamed:@"radio_pressed"]];
        self.outpatient = expertOutpatient;
        
        // 设置科室的内容为专家门诊内容
        if (self.team == KangFuTag) {
            selectedDepartment  = [expertDepartment objectAtIndex:0];
        }
        else{
            selectedDepartment = [departmentInfo objectAtIndex:0];
        }
        categaryLabel.text = selectedDepartment.DepartmentName;
    }
    
}
#pragma - mark 选择医院
- (IBAction)chooseHospital:(id)sender {
    // 弹出ActionSheet
    
    UIActionSheet *hospitalAction = [[UIActionSheet alloc] initWithTitle:@"选择医院" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil];
    
    // 设置tag值，用于区分是哪个action
    hospitalAction.tag = hospitalAcionTag;
    
    // 设置action的各个标题
    for(hospitalModel *model in hospitalInfo){
        [hospitalAction addButtonWithTitle:model.hospitalName];
    }
    
    // 显示actionSheet
    [hospitalAction showInView:self.view];
    
    [hospitalAction release];

}
#pragma - mark 选择科室
- (IBAction)chooseRoom:(id)sender {
    
    UIActionSheet *departmentSheet = [[UIActionSheet alloc] initWithTitle:@"选择科室" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil];
    
    // 设置tag值
    departmentSheet.tag = departmentActionTag;
    
    if (self.team==KangFuTag) {
        if (self.outpatient == expertOutpatient) {
            // 专家门诊科室的内容
            for(departmentModel *model in expertDepartment){
                [departmentSheet addButtonWithTitle:model.DepartmentName];
            }
        }
        else if(self.outpatient == ordinaryOutpatient){
            // 普通门诊科室内容
            for(departmentModel *model in ordinaryDepartment){
                [departmentSheet addButtonWithTitle:model.DepartmentName];
            }
            
        }

    }
    else{
        for(departmentModel *model in departmentInfo){
            [departmentSheet addButtonWithTitle:model.DepartmentName];
        }
    }
    [departmentSheet showInView:[UIApplication sharedApplication].keyWindow];
    [departmentSheet release];
    
    
    
}
#pragma - mark选择日期
-(void)cancelSelect:(id)sender
{
    NSLog(@"取消");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame = CGRectMake(5, 600, 310, 260);
  
    [UIView commitAnimations];
//    [dateView removeFromSuperview];
    [self.grayView removeFromSuperview];
}
-(void)selectDate:(id)sender
{
    NSLog(@"确定%@",datePicker.date);
    // 获取选择的时间
    self.selectedDate =[NSDate dateWithTimeInterval:0 sinceDate:datePicker.date];
    NSString *date = [[NSString stringWithFormat:@"%@",datePicker.date] substringToIndex:10];
    
    if ([datePicker.date compare:[[NSDate date] dateByAddingTimeInterval:-60]]==NSOrderedAscending) {
        // 如果选择时间比当前时间晚，则将时间改成当前时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        dateLabel.text = [[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10];
        [dateFormatter release];
        
        
        
        
        [self.view showToast:@"不可预约昨天及以前的时间" withDuration:1.5];
        
    }
    else
    {
        dateLabel.text = date;
        
    }
    [self cancelSelect:nil];
    
}
- (IBAction)chooseDate:(id)sender {
   
    NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    if (IS_IOS7) {
        NSLog(@"YES");
//        self.blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, 320, 514)];
//        
//        [self.view addSubview:self.blurView];
        
        self.grayView = [[UIView alloc] initWithFrame:ccr(0, 0, 320, 568)];
        self.grayView.backgroundColor = [UIColor grayColor];
        self.grayView.alpha = 0.4;
        [self.view addSubview:self.grayView];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 310, 195)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        dateView = [[UIView alloc] initWithFrame:CGRectMake(5, 600, 310, 240)];
        [dateView addSubview:datePicker];
        
        
        UIButton *cancelButton = [[UIButton alloc] init];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(5, 195, 150, 44)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelSelect:) forControlEvents:UIControlEventTouchUpInside];
        [dateView addSubview:cancelButton];
        
    
       
        UIButton *confirmButton = [[UIButton alloc] init];
    
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setFrame:CGRectMake(150, 195, 150, 44)];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor colorWithRed:0 green:148.0/255.0 blue:247.0/255.0 alpha:1] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [dateView addSubview:confirmButton];
        
        [self.view addSubview:dateView];
        dateView.backgroundColor = [UIColor whiteColor];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        dateView.frame = CGRectMake(5, 260, 310, 240);
        dateView.layer.cornerRadius = 4.0;
        dateView.layer.borderWidth = 0.5;
        dateView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [UIView commitAnimations];

    }
    else{
        popAlertView *dateAlert = [[popAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        dateAlert.frame = CGRectMake(30, 30, 200, 500);
        dateAlert.tag = 10;
        [dateAlert show];
    }
//    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(20, 100, 200, 500)];
//    [self.view addSubview:picker];
    
//    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
//    picker.datePickerMode = UIDatePickerModeDate;
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择时间" message:Nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    alert.frame = CGRectMake(20, 50, 320, 250);
//    [alert addSubview:picker];
//    [alert show];
}
#pragma - mark 提交预约
- (IBAction)subimitAppointment:(id)sender {
   
    [activity startActivity:self.view parentViewDisabled:YES];
    scheduleResultVC *resultVC = [[scheduleResultVC alloc] initWithNibNameSupportIPhone5AndIPad:@"scheduleResultVC"];
    resultVC.tag = self.team;
    resultVC.appointDelegate = self;
    resultVC.selectedHospital = selectedHospital;
    resultVC.selectedDept = selectedDepartment;
    resultVC.selectedDate =selectedDate;
    
    if (self.outpatient == expertOutpatient) {
        resultVC.isExpert = YES;
    }
    else{
        resultVC.isExpert = NO;
    }
    if (self.team==JiangBinTag) {
        #pragma - mark 江滨集团 获取预约信息
        searchList *search = [[searchList alloc] initSearch];
        
        search.parentView = self.view;
        
        search.delegate = resultVC.delegate;
        
        search.tag = JiangBinTag;
        
        
        [search getSearchListWithHospitalCode:selectedHospital.hospitalCode DeptId:selectedDepartment.DepartmentID WorkDate:dateLabel.text];
    }
    else if(self.team == KangFuTag){
        #pragma - mark 康复集团 获取预约信息
        if (self.outpatient == ordinaryOutpatient) {
            // 普通门诊
            searchList *search = [[searchList alloc] initSearch];
            
            search.parentView = self.view;
            
            search.tag = KangFuTag;
            
            search.delegate = resultVC.delegate;
            
            [search searchScheduleByDeparmentWithHospitalCode:selectedHospital.hospitalCode deptCode:selectedDepartment.DepartmentID Monday:dateLabel.text Sunday:dateLabel.text];
        }
        else if (self.outpatient == expertOutpatient){
            // 专家门诊
            searchList *search = [[searchList alloc] initSearch];
            
            search.parentView = self.view;
            
            search.tag = expertOutpatient;
            
            search.delegate = resultVC.delegate;
            [search searchExpertScheduleWithHospitalCode:selectedHospital.hospitalCode DeptCode:selectedDepartment.DepartmentID StartDate:dateLabel.text];
        }
        
        
        
    }
      [selectedDate release];  
}
-(void)AppointJiangBinFailed:(scheduleResultVC *)theSchedule
{
    [activity stopActivity];
    [self.view showToast:theSchedule.errorMessage withRect:ccr(10, 310, 300, 30) withDuration:2];
}
-(void)appointmentResult:(scheduleResultVC *)theSchedule
{
    [activity stopActivity];
    if (theSchedule.isPush) {
       
        [self.navigationController pushViewController:theSchedule animated:YES];
    }
    else{
       
        [self.view showToast:@"未获取到所选日期排班信息，请选择其他日期" withRect:ccr(10, 310, 300, 30) withDuration:2];
    }

}
@end
