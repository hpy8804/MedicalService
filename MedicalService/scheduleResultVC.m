//
//  scheduleResultVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-16.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "scheduleResultVC.h"
#import "AppointHeader.h"

@interface scheduleResultVC ()<searchListDelegate,deptTimeScheduleDelegate,regDelegate,expertResourceDelegate,confirmDelegate,patientInfoDelegate,AppointRecordDelegate,kangFuAppointmentRecordDelegate,ScheduleIDSearchDelegete>
{
    NSMutableArray *scheduleResult;// 上一个界面选择医院、科室，预约日期之后得到的可预约信息(包括预约日期，总预约数，可预约数，预约时间)
    
    NSMutableArray *resultTableArray;// 根据用户所选集团（江滨或是康复集团），门诊（普通或是专家门诊），以及日期的先后对scheduleResult的数据进行筛选排序之后得到的数组，用来显示在第一个table上
    
    NSMutableArray *scheduleTableArray;// 显示可预约信息的时间段表，选中第一个table的某行之后弹出的第二个table上的数据来源
    
    NSString *currentSchId;//江滨医院的排班号
    NSInteger gender;// 注册时性别；1为男2为女
    NSInteger cardType;
    
    NSMutableArray *ExpertArray;// 用来存储专家信息
    
    NSUInteger requestNum;// 记录请求次数
    
    NSString *selectedHour;// 记录康复专家列表上所选的时间，用来筛选
    
    NSString *kangFuExpertScheduleID;// 记录康复专家时间段表所选时间段的排班号码，用来确认预约时传值给接口
    
    NSArray *dateArray;// 存储各个预约日期
    
    NSInteger currentDateIndex;
    
    NSMutableArray *JiangBinFirstTableArray;
}
@end

@implementation scheduleResultVC
@synthesize tag;
@synthesize selectedDate;
#pragma mark - ViewController生命周期方法

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activity = [[FLActivity alloc] init];
        
        scheduleResult = [[NSMutableArray alloc] init];
        
        resultTableArray = [[NSMutableArray alloc] init];
        
        scheduleTableArray = [[NSMutableArray alloc] init];
        
        ExpertArray = [[NSMutableArray alloc] init];
        
        dateArray = [[NSArray alloc] init];
        
        self.delegate = self;
        
        requestNum=0;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [activity stopActivity];
    self.title = self.selectedHospital.hospitalName;
    [(UILabel *)[self.view viewWithTag:SUBTITILE_TAG]  setText:self.selectedDept.DepartmentName];
    currentDateIndex = 0;
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([dateArray count]>0) {
         dateLabel.text = [dateArray objectAtIndex:currentDateIndex];
    }
   
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
    [currentSchId release];
    [scheduleTableArray release];
    [resultTableArray release];
    [scheduleResult release];
}
#pragma mark 请求专家信息（康复）
-(void)requestExpertDetail
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *now = [formatter stringFromDate:selectedDate];
    [formatter release];
    [resultTableArray removeAllObjects];
    // 先将得到的专家计划表信息按日期筛选
    for(expertScheduleInfo *expertInfoModel in scheduleResult){
        if ([expertInfoModel.scheduleDate  compare:now]==NSOrderedDescending||[expertInfoModel.scheduleDate compare:now]==NSOrderedSame) {
    
            [resultTableArray addObject:expertInfoModel];
        }
    }
    
    // 然后按日期排序
    resultTableArray = [[self startArraySort:@"scheduleDate" isAscending:YES Array:resultTableArray] retain];
    
    
    // 将各个值的日期单独拿出来组成数组，并按从小到大顺序排放
    NSMutableArray *date = [[NSMutableArray alloc] init];
    for(expertScheduleInfo *Model in scheduleResult)
    {
        if (![date containsObject:Model.scheduleDate]) {
            [date addObject:Model.scheduleDate];

        }
    
    }
   
    dateArray =[[date sortedArrayUsingSelector:@selector(compare:)] retain];
     [date release];
    
    // 然后将resourceId提取出来，删除其中重复的resourceID，以免请求重复，浪费时间
    NSMutableArray *resourceId = [NSMutableArray array];
    
    for(expertScheduleInfo *Model in resultTableArray){
        
        if (![resourceId containsObject:Model.resourceID]) {
            [resourceId addObject:Model.resourceID];
        }
    }
    // 然后根据其resourceId请求
    for(NSString *resource in resourceId){
        
        [activity startActivity:self.view];
        
        requestNum ++;
        
        expertResourceScheduleDetail *getExpertDetail = [[expertResourceScheduleDetail alloc] initExpert];
        
        getExpertDetail.delegate = self;
        
        [getExpertDetail GetExperInfoByResourceID:resource];
    }
    
}
#pragma mark - 筛选结果
// 根据日期升序排列
-(NSMutableArray *)startArraySort:(NSString *)keystring isAscending:(BOOL)isAscending Array:(NSArray *)array
{
    
    NSSortDescriptor *sortByA = [NSSortDescriptor sortDescriptorWithKey:keystring ascending:isAscending];
    
    NSMutableArray *result = [NSMutableArray  arrayWithArray:[array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByA,nil]]];
    
    return result;

}

// 筛选结果
- (void)fiterResult
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 康复集团
    if (self.tag== KangFuTag) {
        
        [formatter setDateFormat:@"MM-dd-yyyy"];
        
        NSString *nowDate = [formatter stringFromDate:[NSDate date]];
        
        [formatter setDateFormat:@"HH"];
        
        NSString *nowTime = [formatter stringFromDate:[NSDate date]];
        
        [resultTableArray removeAllObjects];
        
        // 按日期对结果进行筛选，比当前时间早的去除，不可预约
        for(deptAppointmentModel *model in scheduleResult){
            
            if ([model.appointmentDate compare:nowDate]==NSOrderedDescending) {
                
                [resultTableArray addObject:model];
            }
            else if([model.appointmentDate isEqualToString:nowDate]){
                
                if([model.appointmentTime integerValue]>[nowTime integerValue])
                {
                    [resultTableArray addObject:model];
                }
            }
            

        }
        // 按日期先后排序
        resultTableArray = [[self startArraySort:@"appointmentDate" isAscending:YES Array:resultTableArray] retain];
        
        // 将各个值的日期单独拿出来组成数组，并按从小到大顺序排放
        NSMutableArray *date = [[NSMutableArray alloc] init];
        
        for(deptAppointmentModel *deptModel in scheduleResult)
        {
            if (![date containsObject:deptModel.appointmentDate]) {
                [date addObject:deptModel.appointmentDate];
            }

            dateArray =[[date sortedArrayUsingSelector:@selector(compare:)] retain];
        
        }
        [date release];
    }
    else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *now = [formatter stringFromDate:[NSDate date]];
        
        // 江滨集团
        // 对结果进行筛选
        for(searchListModel *seaModel in scheduleResult){
            
            if (self.isExpert) {
                
                // 专家门诊只显示有专家的预约信息
                if ([seaModel.doctorId length]>0&&[seaModel.workDate compare:now]==NSOrderedDescending) {
                    
                    // doctorId有值说明有专家坐诊
                    [resultTableArray addObject:seaModel];
                }
            }
            else{
                // 普通门诊只显示普通的预约信息
                if (![seaModel.doctorId length]>0&&[seaModel.workDate compare:now]==NSOrderedDescending) {
                    
                    // doctorId无值说明是普通门诊
                    [resultTableArray addObject:seaModel];
                }
            }
        
        }
        // 按时间排序
        resultTableArray = [[self startArraySort:@"beginTime" isAscending:YES Array:resultTableArray] retain];
        
        NSMutableArray *date = [[NSMutableArray alloc] init];
        
        for(searchListModel *seaModel in resultTableArray)
        {
            if (![date containsObject:seaModel.workDate]) {
                [date addObject:seaModel.workDate];
            }
        }
        dateArray =[[date sortedArrayUsingSelector:@selector(compare:)] retain];
        [date release];
    }
    [formatter release];
     
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 跳转到查看预约的界面
    AppointRecord *recordVC = [[AppointRecord alloc] initWithNibNameSupportIPhone5AndIPad:@"AppointRecord"];
    
    queryAppRecord *queryRecord = [[queryAppRecord alloc] initRecord];
    
    if (alertView.tag==JiangBinTag) {
        [activity startActivity:self.view];
        recordVC.delegate = self;
        
        queryRecord.delegate = recordVC.recordDelegate;
        
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        
        NSString *IdNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"IDNumber"];
        
        [queryRecord queryRecordByPhoneNumber:phone OrIdNumber:IdNumber];
    }
    else if (alertView.tag==KangFuTag){
        [activity startActivity:self.view];
        KangFuAppointRecord *kangfuRecord = [[KangFuAppointRecord alloc] initWithNibNameSupportIPhone5AndIPad:@"KangFuAppointRecord"];
        kangfuRecord.delegate = self;
        queryRecord.delegate = kangfuRecord.recordDelegate;
        NSString *patientName  = [[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuName"];
        NSString *telephone = [[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuPhone"];
        NSString *IDNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuIdNumber"];
        [queryRecord searchAppointmentByPatientName:patientName Telephone:telephone IDNumber:IDNumber];
    }
    
    
}
#pragma mark - textField 代理方法
// textField代理方法，键盘弹出时调用
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 阻止键盘挡住输入框
    [TPScrollView adjustOffsetToIdealIfNeeded];
    textField.layer.borderColor = [[UIColor orangeColor] CGColor];
    textField.layer.borderWidth = 2.5;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = [[UIColor blackColor] CGColor];
    textField.layer.borderWidth = 1.5;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==310) {
        [[patientRegisterView viewWithTag:320] becomeFirstResponder];
        [[personalInfoView viewWithTag:320] becomeFirstResponder];
    }
    else if(textField.tag == 320){
        [[patientRegisterView viewWithTag:330] becomeFirstResponder];
        [[personalInfoView viewWithTag:330] becomeFirstResponder];
    }
    else if (textField.tag==330){
        [[patientRegisterView viewWithTag:330] resignFirstResponder];
        [[personalInfoView viewWithTag:340] becomeFirstResponder];
    }
    else if (textField.tag==340){
        [[personalInfoView viewWithTag:350] becomeFirstResponder];
    }
    else if (textField.tag==350){
        [[personalInfoView viewWithTag:360] becomeFirstResponder];
    }
    return YES;
}
#pragma mark - 列表代理 TableView DataSource & Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (scheduleCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JiangBinFirstTableArray = [[NSMutableArray alloc] init];
    if (tableView.tag == SELF_TABLEVIEW_TAG) {
        NSInteger counts=0;
        if (self.tag==JiangBinTag) {
            
            for(searchListModel *model in resultTableArray){
                if ([model.workDate isEqualToString:dateLabel.text]) {
                    [JiangBinFirstTableArray addObject:model];
                    counts++;
                }
            }
            return counts;
        }
        else{
            if (self.isExpert) {
                for(expertScheduleInfo *infoModel in resultTableArray){
                    if ([infoModel.scheduleDate isEqualToString:dateLabel.text]) {
                        counts ++;
                        
                    }
                }
                return counts;
            }
            return [resultTableArray count];
        }
        
    }
    else{
        return [scheduleTableArray count];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==SELF_TABLEVIEW_TAG) {
        
        // 第一个table，用来显示预约信息的table
        scheduleCell *cell = [scheduleCell reuseableCell:tableView withOwner:nil];
        
        if (indexPath.row<[resultTableArray count]) {
            
            cell.number.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
            cell.background.layer.masksToBounds = YES;
            cell.background.layer.cornerRadius = 5.0;
            
            // 康复医院普通门诊的数据
            if (self.tag==KangFuTag) {
                // 康复医院专家门诊数据
                if (self.isExpert) {
                    expertScheduleInfo *model = [resultTableArray objectAtIndex:indexPath.row];
                    
                    [(UILabel *)[cell viewWithTag:20] setText:@"可预约数："];
                    
                    [(UILabel *)[cell viewWithTag:30] setText:@"医生名："];
                    cell.date.text = model.scheduleDate;
                    cell.timeSlice.text = [NSString stringWithFormat:@"%@:00~%@:59",model.hour,model.hour];
                    cell.appointTime.text = model.hour;
                    cell.total.text = model.count;
                    for(expertInfoModel *infoModel in ExpertArray){
                        if ([infoModel.resourceID isEqualToString:model.resourceID]) {
                            cell.availableNumber.text = infoModel.expertName;
                        }
                    }
                
                    
                }else{
                    deptAppointmentModel *model = [resultTableArray objectAtIndex:indexPath.row];
                    cell.timeSlice.text = [NSString stringWithFormat:@"%@:00-%@:59",model.appointmentTime,model.appointmentTime];
                    cell.date.text = model.appointmentDate;
                    cell.appointTime.text = model.appointmentTime;
                    cell.total.text = model.total;
                    cell.availableNumber.text = [NSString stringWithFormat:@"%i",[model.total integerValue]-[model.ordered integerValue]];
                }
            }
            // 江滨集团数据
            else if (self.tag==JiangBinTag){
                
                searchListModel *listModel =  [JiangBinFirstTableArray objectAtIndex:indexPath.row];
                // 只显示所选日期的数据
                if ([listModel.workDate isEqualToString:dateLabel.text]) {
                    
                    cell.timeSlice.text = [NSString stringWithFormat:@"%@~%@",listModel.beginTime,listModel.endTime];
                    
                    [(UILabel *)[cell viewWithTag:20] setText:@"可预约数："];
                    
                    [(UILabel *)[cell viewWithTag:30] setText:@"医生名："];
                    cell.date.text = listModel.workDate;
                    cell.appointTime.text = listModel.dateSlotName;
                    // 设置可预约数
                    if ([listModel.appCount isEqualToString:@"-1"]) {
                        cell.total.text = @"无需预约";
                    }
                    else{
                        cell.total.text = listModel.appCount;
                    }
                    // 设置医生名
                    if (![listModel.doctorId length]>0) {
                        cell.availableNumber.text = [NSString stringWithFormat:@"无(%@)",listModel.ticketTypeName];
                    }
                    else{
                        cell.availableNumber.text = [NSString stringWithFormat:@"%@(%@)",listModel.doctorName,listModel.ticketTypeName];
                    }

                }
                
            }
            
        }
        return cell;

    }
    // 弹出的时间段表，第二个table，选中第一个table的某一行之后弹出的
    popScheduleCell *popCell = [popScheduleCell reuseableCell:tableView withOwner:nil];
    // 康复集团普通门诊的数据
    if (self.tag == KangFuTag) {
        if (self.isExpert) {
            expertScheduleDetalModel *model = [scheduleTableArray objectAtIndex:indexPath.row];
            NSArray *start = [model.sliceStartTime componentsSeparatedByString:@" "];
            NSArray *end = [model.sliceEndTime componentsSeparatedByString:@" "];
            popCell.timeLabel.text = [NSString stringWithFormat:@"%@~%@",[start lastObject],[end lastObject]];
            popCell.numberLabel.text = model.registNumber;
        }
        else{
            deptTimeModel *model = [scheduleTableArray objectAtIndex:indexPath.row];
            if (model.sliceStartTime!=nil) {
                popCell.timeLabel.text = model.sliceStartTime;
                popCell.numberLabel.text =[NSString stringWithFormat:@"%d", [model.total integerValue]-[model.ordered integerValue]];
            }
        }
        
    }
    // 江滨集团的数据
    else{
        ticketListModel *model = [scheduleTableArray objectAtIndex:indexPath.row];
        [(UILabel *)[scheduleTimeView viewWithTag:11] setText:@"预约号码"];
        [(UILabel *)[scheduleTimeView viewWithTag:12] setText:@"估计时间"];
        popCell.timeLabel.text = model.tickerNo;
        popCell.timeLabel.textAlignment = NSTextAlignmentCenter;
        [popCell.timeLabel setFrame:ccr(52, 0, 78, 21)];
        popCell.numberLabel.textAlignment = NSTextAlignmentCenter;
        popCell.numberLabel.text = model.apptTime;
        [popCell.numberLabel setFrame:ccr(170, 0, 103, 21)];
    }
    
    return popCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 选中弹出时间段列表的某一行时，第二个table
    if (tableView.tag == SCHEDULE_TABLEVIEW_TAG) {
        
        deptTimeModel *selectedTimeModel = [scheduleTableArray objectAtIndex:indexPath.row];
        // 康复集团
        if (self.tag==KangFuTag) {
            
            if (self.isExpert) {
                // 如果是康复专家门诊
        
                [self popUpKangFuAppointment];
                expertScheduleDetalModel *model = [scheduleTableArray objectAtIndex:indexPath.row];
                kangFuExpertScheduleID = [[NSString alloc] initWithString:model.scheduleID];
                
            }
            else{
                if ([selectedTimeModel.total integerValue] == [selectedTimeModel.ordered integerValue]) {
                    // 没有预约数，则不作任何操作
                    [scheduleTimeView showToast:@"无预约数，请选择其他时段"];
                    return;
                }
                else{
                    // 请求scheduleID
                    [activity startActivity:scheduleTimeView parentViewDisabled:YES];
                    deptTimeModel *model = [scheduleTableArray objectAtIndex:indexPath.row];
                    ScheduleIDByTimeSlice *searchScheduleID = [[ScheduleIDByTimeSlice alloc] initSchedule];
                    searchScheduleID.delegate = self;
                    NSArray *timeSlice = [model.sliceStartTime componentsSeparatedByString:@" "];
                    [searchScheduleID scheduleIDSearchByTimeSlice:[timeSlice lastObject] HospitalCode:self.selectedHospital.hospitalCode DeptCode:self.selectedDept.DepartmentID ScheduleDate:dateLabel.text];
                   
                }
            }
        }
        // 江滨集团
        else{
            // 弹出预约界面
            [scheduleTimeView setHidden:YES];
            NSInteger Tag[] = {310,320,330,340,350,360};
            for(int index = 0;index<6;index++){
                UITextField *textField = (UITextField *)[BookView viewWithTag:Tag[index]];
                textField.layer.masksToBounds = YES;
                textField.layer.cornerRadius = 4.0;
                textField.layer.borderWidth = 1.5;
                textField.layer.borderColor = [[UIColor grayColor] CGColor];
            }
            [self popUpView:BookView];
            
            // 设置bookView上的信息
            ticketListModel *ticketModel = [scheduleTableArray objectAtIndex:indexPath.row];
            if (ticketModel!=nil) {
                [(UITextField *)[BookView viewWithTag:310] setText:self.selectedHospital.hospitalName];// 医院
                
                [(UITextField *)[BookView viewWithTag:320] setText:self.selectedDept.DepartmentName];// 科室
                
                [(UITextField *)[BookView viewWithTag:330] setText:ticketModel.apptTime];// 时间
                
                [(UITextField *)[BookView viewWithTag:340] setText:currentSchId];// 排班号
                
                [(UITextField *)[BookView viewWithTag:350] setText:ticketModel.ticketId];// 预约号
            }
            [BookView showToast:@"请双击背景返回" withRect:ccr(40,200,250,35) withDuration:2];
            
            // 双击背景界面消失
            [[BookView viewWithTag:100] whenDoubleTapped:^{
                [scheduleTimeView setHidden:NO];
                [BookView removeFromSuperview];
            }];
        }
        return;
    }
    // 选中为预约信息界面列表某一行时,第一个table
    else if(tableView.tag == SELF_TABLEVIEW_TAG){
        // 如果是江滨集团
        if (self.tag == JiangBinTag) {
            if (self.isExpert) {
                // 如果是专家门诊
                
                // 请求专家预约时间段
                [self popUpScheduleShowWithIndexPath:indexPath];
                return;
            }
            // 不是专家门诊不需预约
            [self.view showToast:@"无预约数" withRect:ccr(110, 320, 100, 30)];
        }
        // 如果是康复集团
        else {
            // 请求时间段表信息
            [self popUpScheduleShowWithIndexPath:indexPath];
        }
    }
    
    
}
-(void)popUpKangFuAppointment
{
    [scheduleTimeView setHidden:YES];
    [self popUpView:personalInfoView];
    // 获取存储的信息填充textField
    NSInteger Tag[] = {310,320,330,340,350,360};
    for(int index = 0;index<6;index++){
        UITextField *textField = (UITextField *)[personalInfoView viewWithTag:Tag[index]];
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 4.0;
        textField.layer.borderWidth = 1.0;
        textField.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    [(UITextField *)[personalInfoView viewWithTag:310] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuName"]];
    [(UITextField *)[personalInfoView viewWithTag:320] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuPhone"]];
    [(UITextField *)[personalInfoView viewWithTag:340] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuIdNumber"]];
    [(UITextField *)[personalInfoView viewWithTag:350] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuCard"]];
    [(UITextField *)[personalInfoView viewWithTag:360] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuTel"]];
    gender=1;
    // 性别的获取
    UIButton *male = (UIButton *)[personalInfoView viewWithTag:410];
    UIButton *female = (UIButton *)[personalInfoView viewWithTag:420];
    [male whenTapped:^{
        [male setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [female setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        gender=1;
    }];
    [female whenTapped:^{
        [female setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [male setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        gender=2;
    }];
    
    // 卡类型的获取
    
    UIButton *medicalInsurance = (UIButton *)[personalInfoView viewWithTag:430];
    UIButton *seeADoctor = (UIButton *)[personalInfoView viewWithTag:440];
    UIButton *other = (UIButton *)[personalInfoView viewWithTag:450];
    
    [medicalInsurance whenTapped:^{
        [medicalInsurance setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [seeADoctor setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        [other setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        cardType = 1;
    }];
    [seeADoctor whenTapped:^{
        [seeADoctor setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [medicalInsurance setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        [other setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        cardType=2;
    }];
    [other whenTapped:^{
        [other setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [medicalInsurance setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        [seeADoctor setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        cardType=3;
    }];
    
    [[personalInfoView viewWithTag:100] whenDoubleTapped:^{
        [scheduleTimeView setHidden:NO];
        [personalInfoView removeFromSuperview];
    }];
}
#pragma mark - 请求时间段表上的数据
-(void)popUpScheduleShowWithIndexPath:(NSIndexPath *)indexPath
{
    // 定义请求
    deptTimeScheduleService *timeScheduleService = [[deptTimeScheduleService alloc] init];
    
    timeScheduleService.tag = self.tag;
    
    // 设置代理
    timeScheduleService.delegate = self;
    
    [activity startActivity:self.view parentViewDisabled:YES];
    // 江滨集团
    if (self.tag == JiangBinTag) {
        
        searchListModel *model = [resultTableArray objectAtIndex:indexPath.row];
        currentSchId = [[NSString alloc] initWithString:model.schId];
        [timeScheduleService requestJiangBinTimeScheduleWithSchId:model.schId];
        
    }
    // 康复集团
    else if (self.tag==KangFuTag) {
        // 专家门诊
        if (self.isExpert) {
            // 专家的预约列表信息，选中后获取时间段表
            expertScheduleInfo *info = [resultTableArray objectAtIndex:indexPath.row];
            expertResourceScheduleDetail *scheduleDetail = [[expertResourceScheduleDetail alloc] initExpert];
            scheduleDetail.delegate = self;
            NSString *isAm = [info.hour integerValue]<12?@"0":@"1";
            selectedHour = [[NSString alloc] initWithString:info.hour];
            // 请求专家的时间段数据
            [scheduleDetail requestExpertScheduleByResourceID:info.resourceID CurrentDate:dateLabel.text IsAm:isAm];
        }
        // 普通门诊
        else{
            deptAppointmentModel *model = [resultTableArray objectAtIndex:indexPath.row];
            
            [timeScheduleService requestKangFuDeptTimeScheduleWithHospitalCode:self.selectedHospital.hospitalCode DeptCode:self.selectedDept.DepartmentID ScheduleDate:model.appointmentDate Hour:model.appointmentTime];
        }
    }
    
    
    
}
// 弹出某个pop
-(void)popUpView:(UIView *)popView
{
    [popView setAlpha:0];
    
    UIView *subView = [popView viewWithTag:200];
    // 设置圆角
    subView.layer.masksToBounds = YES;
    
    subView.layer.cornerRadius = 4;
    
    subView.layer.borderWidth=3.0;
    
    subView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // 添加到屏幕
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    // 定义动画
    [UIView animateWithDuration:0.75 animations:^{
        [popView setAlpha:1];
        
    } ];
    
}
#pragma mark - 各种自定义的代理方法
#pragma mark 查询scheduleID回调方法
-(void)getScheduleIDSucced:(ScheduleIDByTimeSlice *)schedule
{
    [activity stopActivity];
    kangFuExpertScheduleID = [schedule getScheduleID];
    // 有预约数，弹出填写信息界面方便预约
    [self popUpKangFuAppointment];
}
#pragma mark   regDelegate 注册成功后回调方法
-(void)getPatientInfoFinished:(regPatientInfo *)theReg
{
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)patientRegisterView viewWithTag:310] forKey:@"patientName"];
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)patientRegisterView viewWithTag:320] forKey:@"IDNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)patientRegisterView viewWithTag:330] forKey:@"phone"];
     NSString *patientId = [theReg getPatientId];
    [patientRegisterView removeFromSuperview];
    [BookView setHidden:NO];
    [(UITextField *)[BookView viewWithTag:360] setText:patientId];
    
}
// 注册失败回调方法
-(void)registerFailed:(regPatientInfo *)theReg
{
    NSString *msg = [theReg getMessage];
    [patientRegisterView showToast:msg withRect:ccr(20, 200, 280, 35)];
}

#pragma  mark  deptTimeScheduleDelegate 获取计划表成功后回调方法

-(void)getDeptTimeScheduleFinished:(deptTimeScheduleService *)timeSchedule
{
    scheduleTableArray = [timeSchedule getDeptScheduleResult];
    
    [activity stopActivity];
    

    [self popUpView:scheduleTimeView];
    [(UITableView *)[scheduleTimeView viewWithTag:30] reloadData];
    [[scheduleTimeView viewWithTag:100] whenTapped:^{
        [scheduleTimeView removeFromSuperview];
    }];
    [[scheduleTimeView viewWithTag:SCHEDULE_BACK_TAG] whenTapped:^{
        [scheduleTimeView removeFromSuperview];
    }];

}
#pragma mark patientInfoDelegate 查询病人标识符
// 查询标识符成功
-(void)getPatientInfoSuccess:(getPatientInfo *)thePatientInfo
{
    [activity stopActivity];
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[PatientIDView viewWithTag:310] text] forKey:@"patientName"];
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[PatientIDView viewWithTag:320] text]forKey:@"IDNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[PatientIDView viewWithTag:330] text] forKey:@"phone"];
    
    NSMutableArray *array = [thePatientInfo getPatientInfoArray];
    patientInfo *model = [array lastObject];
    [PatientIDView removeFromSuperview];
    [BookView setHidden:NO];
    [(UITextField *)[BookView viewWithTag:360] setText:model.patientId];
}
// 查询标识符失败
-(void)getPatientInfoFailed:(getPatientInfo *)thePatientInfo
{
    [activity stopActivity];
    // 显示失败信息
    [PatientIDView showToast:[thePatientInfo getMessage] withRect:ccr(20, 200, 280, 35)];
    [PatientIDView removeFromSuperview];
    [BookView setHidden:NO];
}
#pragma mark expertDelegate
-(void)getScheduleDetailFinished:(expertResourceScheduleDetail *)theExpert
{
    [activity stopActivity];
    NSMutableArray *array = [theExpert expertSchedleArray];
    [scheduleTableArray removeAllObjects];
    for(expertScheduleDetalModel *model in array)
    {
        if ([model.currentHour isEqualToString:selectedHour]) {
            [scheduleTableArray addObject:model];
        }
    }
    
    [self popUpView:scheduleTimeView];
    [(UITableView *)[scheduleTimeView viewWithTag:30] reloadData];
    [[scheduleTimeView viewWithTag:100] whenTapped:^{
        [scheduleTimeView removeFromSuperview];
    }];
    [[scheduleTimeView viewWithTag:SCHEDULE_BACK_TAG] whenTapped:^{
        [scheduleTimeView removeFromSuperview];
    }];
    
    
}
-(void)getExpertFinished:(expertResourceScheduleDetail *)theExpert
{
    expertInfoModel *model = [theExpert getExpert];
    [ExpertArray addObject:model];
    if ([ExpertArray count] == requestNum) {
        [activity stopActivity];
        self.isPush = YES;
        // 代理响应
       
        if ([_appointDelegate respondsToSelector:@selector(appointmentResult:)]) {
            [self.appointDelegate appointmentResult:self];
        }
    }
    
}
#pragma mark searchListDelegate
-(void)JiangBinMessageFailed:(searchList *)theSearchList
{
    self.isPush = NO;
    self.errorMessage = [theSearchList getMessage];
    if ([_appointDelegate respondsToSelector:@selector(AppointJiangBinFailed:)]) {
        [self.appointDelegate AppointJiangBinFailed:self];
    }
    
}

-(void)getSearchLishFinished:(searchList *)theSearchList
{
        
       self.isPush = NO;
    // 江滨集团
    if (theSearchList.tag==JiangBinTag) {
        // 第一个table的信息源
        scheduleResult = [theSearchList getJiangBinSearchResult];
        [self fiterResult];
        if ([resultTableArray count]>0) {
            self.isPush = YES;
        }
        else{
            self.isPush = NO;
        }
        // 代理响应
        if ([_appointDelegate respondsToSelector:@selector(appointmentResult:)]) {
            [self.appointDelegate appointmentResult:self];
        }
    }
    // 康复集团普通门诊
    else if(theSearchList.tag == KangFuTag){
        // 第一个table的信息源
        scheduleResult = [theSearchList getKangFuSearchResult];
        [self fiterResult];
        if ([resultTableArray count]>0) {
            self.isPush = YES;
        }
        else{
            self.isPush = NO;
        }
        // 代理响应
        if ([_appointDelegate respondsToSelector:@selector(appointmentResult:)]) {
            [self.appointDelegate appointmentResult:self];
        }

    }
    // 康复集团专家门诊
    else if(theSearchList.tag==expertOutpatient){
        // 第一个table的信息源
        scheduleResult = [theSearchList getExpertSearchResult];
        [self requestExpertDetail];
       
        // 代理响应
        if ([scheduleTableArray count]==0) {
            self.isPush = NO;
            if ([_appointDelegate respondsToSelector:@selector(appointmentResult:)]) {
                [self.appointDelegate appointmentResult:self];
            }
        }
    }
}

#pragma mark confirmDelegate 确认预约
-(void)getConfirmFailed:(ConfirmAppointment *)theConfirmRequest
{
    [activity stopActivity];
    // 确认预约失败，显示失败信息
    if (theConfirmRequest.tag == JiangBinTag) {
        [BookView showToast:[theConfirmRequest getFailMessage]];
    }
    else if (theConfirmRequest.tag == KangFuTag){
        [personalInfoView showToast:[theConfirmRequest getFailMessage]];
    }

}
-(void)getConfirmSuccess:(ConfirmAppointment *)theConfirmRequest
{
    [activity stopActivity];
    if (theConfirmRequest.tag == JiangBinTag) {
        [scheduleTimeView setHidden:NO];
        [BookView setHidden:NO];
        [BookView removeFromSuperview];
        [scheduleTimeView removeFromSuperview];
        NSString *info = [NSString stringWithFormat:@"您的预约编号为：%@",[theConfirmRequest getAppointmentID]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预约成功" message:info delegate:self cancelButtonTitle:nil otherButtonTitles:@"查看预约", nil];
        alert.tag = JiangBinTag;
        [alert show];
        [alert release];
    }
    else if(theConfirmRequest.tag == KangFuTag){
        // 将这些信息存储在程序中，下次可以直接填充
        [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[personalInfoView viewWithTag:310] text] forKey:@"KangFuName"];
        [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[personalInfoView viewWithTag:320] text] forKey:@"KangFuPhone"];
        [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[personalInfoView viewWithTag:340] text] forKey:@"KangFuIdNumber"];
        [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[personalInfoView viewWithTag:350] text] forKey:@"KangFuCard"];
        [[NSUserDefaults standardUserDefaults] setObject:[(UITextField *)[personalInfoView viewWithTag:360] text] forKey:@"KangFuTel"];
        [scheduleTimeView setHidden:NO];
        [personalInfoView setHidden:NO];
        [personalInfoView removeFromSuperview];
        [scheduleTimeView removeFromSuperview];
        NSString *info = [NSString stringWithFormat:@"您的预约编号为：%@",[theConfirmRequest getAppointmentID]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预约成功" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看预约", nil];
        alert.tag=KangFuTag;
        [alert show];
        [alert release];
    }
    
}

#pragma mark recordDelegate
// 江滨集团
-(void)getRecordFinished:(AppointRecord *)recordVC
{
    [activity stopActivity];
    [self.navigationController pushViewController:recordVC animated:YES];
}
// 康复集团
-(void)queryAppointKangFuSucced:(KangFuAppointRecord *)theRecord
{
    [activity stopActivity];
    [self.navigationController pushViewController:theRecord animated:YES];
}
#pragma mark - 按钮事件
#pragma mark  self.view 按钮事件
// 选择上一个日期
- (IBAction)chooseEarlierDate:(id)sender {
    
    if ([dateArray count]==1) {
        [self.view showToast:@"无更多信息" withRect:ccr(110,300,100,30)];
    }
    if (currentDateIndex<=0) {
        currentDateIndex = (currentDateIndex+[dateArray count]-1)%[dateArray count];
    }
    else{
        currentDateIndex = (currentDateIndex - 1)%[dateArray count];
    }
    dateLabel.text = [dateArray objectAtIndex:currentDateIndex];
    [(UITableView *)[self.view viewWithTag:3] reloadData];
    
}
// 选择下一个日期
- (IBAction)chooseLaterDate:(id)sender {
    if ([dateArray count]==1) {
        [self.view showToast:@"无更多信息" withRect:ccr(110,300,100,30)];
    }
    currentDateIndex = (currentDateIndex+1)%([dateArray count]);
    
    dateLabel.text = [dateArray objectAtIndex:currentDateIndex];
    [(UITableView *)[self.view viewWithTag:3] reloadData];
}

#pragma mark  BookView 上的按钮事件

// 预约
- (IBAction)makeAppointment:(id)sender {
    ConfirmAppointment *confirm = [[ConfirmAppointment alloc] initAppoint];
    confirm.delegate = self;
    NSString *schId = [(UITextField *)[BookView viewWithTag:340] text];
    NSString *ticketId = [(UITextField *)[BookView viewWithTag:350] text];
    NSString *patientId = [(UITextField *)[BookView viewWithTag:360] text];
    if (schId==nil) {
        [BookView showToast:@"排班号不可为空"];
        return;
    }
    if (patientId == nil) {
        [BookView showToast:@"病人标识符不可为空"];
        return;
    }
    [activity startActivity:BookView parentViewDisabled:YES];
    confirm.tag = JiangBinTag;
    [confirm confirmWithSchID:schId TicketID:ticketId PatientID:patientId];
}

// 注册
- (IBAction)registerJiangBin:(id)sender {
    
    [BookView setHidden:YES];
    
    [self popUpView:patientRegisterView];
    
    [patientRegisterView showToast:@"请双击背景返回" withRect:ccr(20,200,280,30)];
    gender=1;
    // 选择性别
    UIButton *male = (UIButton *)[patientRegisterView viewWithTag:410];
    UIButton *female = (UIButton *)[patientRegisterView viewWithTag:420];
    [male whenTapped:^{
        [male setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [female setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        gender=1;
    }];
    [female whenTapped:^{
        [female setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [male setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        gender=2;
    }];
    // 触摸背景返回
    [[patientRegisterView viewWithTag:100] whenDoubleTapped:^{
        [BookView setHidden:NO];
        [patientRegisterView removeFromSuperview];
    }];
        
}
// 标识符
- (IBAction)token:(id)sender {
    [BookView setHidden:YES];
    [self popUpView:PatientIDView];
    NSString *patientName = [[NSUserDefaults standardUserDefaults] objectForKey:@"patientName"];
    NSString *IDNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"IDNumber"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    UITextField *name = (UITextField *)[PatientIDView viewWithTag:310];
    UITextField *number = (UITextField *)[PatientIDView viewWithTag:320];
    UITextField *tel = (UITextField *)[PatientIDView viewWithTag:330];
    if (patientName!=nil) {
        [name setText:patientName];
    }
    if (IDNumber!=nil) {
        [number setText:IDNumber];
    }
    if (phone!=nil) {
        [tel setText:phone];
    }
    
    for(NSInteger Tag=310;Tag<350;Tag += 10){
        UITextField *textField = (UITextField *)[PatientIDView viewWithTag:Tag];
        textField.delegate = self;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 6.0;
        textField.layer.borderColor = [[UIColor blackColor] CGColor];
        textField.layer.borderWidth = 1.5;

    }
        
    
    [[PatientIDView viewWithTag:100] whenDoubleTapped:^{
         [BookView setHidden:NO];
        [PatientIDView removeFromSuperview];
    }];
}

#pragma mark  registerView 上的按钮事件

// 填写注册信息后点击注册
- (IBAction)fillRegisterInfo:(id)sender {
    
    // 获取病人姓名
    NSString *patientName = [(UITextField *)[patientRegisterView viewWithTag:310] text];
    // 获取身份证号
    NSString *IDNumber = [(UITextField *)[patientRegisterView viewWithTag:320] text];
    // 获取电话号码
    NSString *phone = [(UITextField *)[patientRegisterView viewWithTag:330] text];
    NSString *birhday = nil;
    
    if (patientName==nil||[patientName length]==0) {
        [patientRegisterView showToast:@"请填写姓名" withRect:ccr(20,220,280,30)];
        return;
    }
    if (IDNumber==nil||[IDNumber length]==0) {
        [patientRegisterView showToast:@"请填写身份证号" withRect:ccr(20,220,280,30)];
        return;
    }
    if (phone==nil) {
        [patientRegisterView showToast:@"请填写电话号码" withRect:ccr(20,220,280,30)];
        return;
    }
    if (IDNumber.length==18)
    {
        birhday =[NSString stringWithFormat:@"%@/%@/%@",[IDNumber substringWithRange:NSMakeRange(6, 4)],[IDNumber substringWithRange:NSMakeRange(10, 2)],[IDNumber substringWithRange:NSMakeRange(12, 2)]];
    }
    else{
        [patientRegisterView showToast:@"身份证号填写不正确" withRect:ccr(20,220,280,30)];
        return;
    }
    
  
    NSArray *sex = [NSArray arrayWithObjects:@"1",@"2", nil];
    regPatientInfo *reg = [[regPatientInfo alloc] initReg];
    reg.delegate = self;
    [reg regPatientInfoWithHospitalCode:self.selectedHospital.hospitalCode PatientName:patientName Birthday:birhday Gender:[sex objectAtIndex:gender-1] IDNumber:IDNumber Phone:phone];
    
}

#pragma mark  personalInfoView 上的按钮事件

// 确定预约
- (IBAction)confirmAppointment:(id)sender {
   // 康复确定预约
    
    /** 获取textField中的文字信息
     *
     *  @param name:姓名
     *  @param phone:电话号码
     *  @param IdNumber:证件号码
     *  @param CardNumber:健康卡号
     *  @param Tel:电话（座机）
     *  @param birthday:生日
     */ 
    NSString *name = [(UITextField *)[personalInfoView viewWithTag:310] text];
    NSString *phone = [(UITextField *)[personalInfoView viewWithTag:320] text];
    NSString *IdNumber = [(UITextField *)[personalInfoView viewWithTag:340] text];
    NSString *cardNumber = [(UITextField *)[personalInfoView viewWithTag:350] text];
    NSString *Tel = [(UITextField *)[personalInfoView viewWithTag:360] text];
    NSString *birthday = nil;
    NSString *cardTP = [NSString stringWithFormat:@"%d",cardType];
    if (name == nil) {
        [personalInfoView showToast:@"请填写姓名"];
        return;
    }
    if (phone==nil) {
        [personalInfoView showToast:@"请填写电话号码"];
        return;
    }
    if (IdNumber==nil) {
        [personalInfoView showToast:@"请填写身份证号"];
        return;
    }
    
    // 根据身份证号判断出生年月日
    if ([IdNumber length]==18) {
        birthday =[NSString stringWithFormat:@"%@-%@-%@", [IdNumber substringWithRange:NSMakeRange(6, 4)],[IdNumber substringWithRange:NSMakeRange(10, 2)],[IdNumber substringWithRange:NSMakeRange(12, 2)]];
    }
    else{
        [personalInfoView showToast:@"身份证号填写不正确"];
        return;
    }
    if(![cardNumber length]>0){
        cardTP = @"";
        
    }
    if (![Tel length]>0) {
        Tel = @"";
    }
    
    
    
    // userInfo传参给接口
    NSString *userInfo = [NSString stringWithFormat:@"<![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?><UserInfo>"
                          "<Name>%@</Name>"
                          "<Phone>%@</Phone>"
                          "<Birthday>%@</Birthday>"
                          "<IDNum>%@</IDNum>"
                          "<Gender>%@</Gender>"
                          "<CardType>%@</CardType>"
                          "<CardNo>%@</CardNo>"
                          "<SecondPhone>%@</SecondPhone>"
                          "<Source>5</Source></UserInfo>]]>",name,phone,birthday,IdNumber,[NSString stringWithFormat:@"%d",gender],cardTP,cardNumber,Tel];
    ConfirmAppointment *confirm = [[ConfirmAppointment alloc] initAppoint];
    confirm.delegate = self;
    confirm.tag = KangFuTag;
    // 康复医院确认预约接口
    [confirm confirmWithScheduleID:kangFuExpertScheduleID UserInfo:userInfo];
    


    
    
}

// 取消预约
- (IBAction)cancel:(id)sender {
    [scheduleTimeView setHidden:NO];
    [personalInfoView removeFromSuperview];
}
#pragma mark patientIDView 上的按钮事件
- (IBAction)queryPatientID:(id)sender {
    NSString *patientName = [(UITextField *)[PatientIDView viewWithTag:310] text];
    NSString *IDNumber = [(UITextField *)[PatientIDView viewWithTag:320] text];
    NSString *phone = [(UITextField *)[PatientIDView viewWithTag:330] text];
    NSString *cardNumber = [(UITextField *)[PatientIDView viewWithTag:340] text];
    if (patientName==nil) {
        [self.view showToast:@"请填写姓名"];
        return;
    }
    
    if (IDNumber==nil) {
        [self.view showToast:@"请填写身份证号"];
        return;
    }
    if (phone==nil) {
        [self.view showToast:@"请填写手机号码"];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:patientName forKey:@"patientName"];
    [[NSUserDefaults standardUserDefaults] setObject:IDNumber forKey:@"IDNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:cardNumber forKey:@"cardNumber"];
    [activity startActivity:PatientIDView parentViewDisabled:YES];
    getPatientInfo *requestPatientID = [[getPatientInfo alloc] initPatient];
    requestPatientID.delegate = self;
    [requestPatientID getpatientInfoByHospitalCode:self.selectedHospital.hospitalCode PatientName:patientName IDNumber:IDNumber Phone:phone CardNumber:cardNumber];
}

@end
