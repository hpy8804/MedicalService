//
//  AppointRecord.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "AppointRecord.h"

#import "appointRecordCell.h"
#import "appRecordModel.h"

#import "cancelAppointment.h"
@interface AppointRecord ()<queryRecordDelegate,cancelAppointmentDelegate>
{
    NSMutableArray  *patientAppRecordTableArray;
    NSString *opaID;
    cancelAppointment *cancel;
    
}
@end

@implementation AppointRecord

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        patientAppRecordTableArray = [[NSMutableArray alloc] init];
        self.recordDelegate = self;
        activity = [[FLActivity alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"江滨集团预约记录";
    
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initSegment];
    NSMutableArray *array =  patientAppRecordTableArray;
    NSMutableArray *uncancelArray = [NSMutableArray array];
    NSMutableArray *canceledArray = [NSMutableArray array];
    
    for(appRecordModel *model in array){
        if ([model.cancelFlag integerValue]==0) {
            [uncancelArray addObject:model];
        }
        else{
            
            [canceledArray addObject:model];
        }
    }
    [patientAppRecordTableArray removeAllObjects];
    [patientAppRecordTableArray addObject:uncancelArray];
    [patientAppRecordTableArray addObject:canceledArray];
    
    if (![[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] count]>0) {
        [self.view showToast:@"无相关预约" withRect:ccr(100,150,120,30)];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [segmemtControl removeFromSuperview];
    [segmemtControl release];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [super dealloc];
    opaID = nil;
    [opaID release];
    [patientAppRecordTableArray release];
    cancel.delegate = nil;
    [cancel release];
}
-(void)initSegment{
    segmemtControl = [[UISegmentedControl alloc] initWithFrame:ccr(100, 6.0, 150, 32)];
    [segmemtControl insertSegmentWithTitle:@"未取消" atIndex:0 animated:NO];
    [segmemtControl insertSegmentWithTitle:@"已取消" atIndex:1 animated:NO];
    //segmemtControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmemtControl.selectedSegmentIndex = 0;
    [segmemtControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmemtControl];
}
-(IBAction)valueChanged:(id)sender{
    
    if (![[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] count]>0) {
        [self.view showToast:@"无相关预约" withRect:ccr(100,150,120,30)];
    }
    [recordTableView reloadData];
}
#pragma mark - 筛选结果
// 根据日期升序排列
-(NSMutableArray *)startArraySort:(NSString *)keystring isAscending:(BOOL)isAscending Array:(NSArray *)array
{
    
    NSSortDescriptor *sortByA = [NSSortDescriptor sortDescriptorWithKey:keystring ascending:isAscending];
    
    NSMutableArray *result = [NSMutableArray  arrayWithArray:[array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByA,nil]]];
    return result;
    
}

#pragma mark - recordDelegate
-(void)RequestPatientFinished:(queryAppRecord *)record
{
    patientAppRecordTableArray = [record getRecordArray];
    patientAppRecordTableArray = [self startArraySort:@"apptDate" isAscending:NO Array:patientAppRecordTableArray];
    if ([patientAppRecordTableArray count]>0&&[_delegate respondsToSelector:@selector(getRecordFinished:)]) {
        [self.delegate getRecordFinished:self];
    }
    
}
-(void)RequestPatientFailed:(queryAppRecord *)record
{
    self.message = [record getMessage];
    if ([_delegate respondsToSelector:@selector(getRecordFailed:)]) {
        [self.delegate getRecordFailed:self];
    }
}
#pragma mark - CancelAppointmentDelegate
-(void)cancelSucced:(cancelAppointment *)cancelRequest
{
    // 取消成功;
    [activity stopActivity];
    [self.view showToast:@"取消预约成功"];
    appointRecordCell *cell = (appointRecordCell *)[recordTableView cellForRowAtIndexPath:self.selectedIndexPath];
    cell.contentLabel.text = @"已取消";
    
}
-(void)cancelFailed:(cancelAppointment *)cancelRequest
{
    [activity stopActivity];
    // 取消失败;
    [self.view showToast:@"操作失败"];
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    [activity startActivity:self.view parentViewDisabled:YES];
    cancel = [[cancelAppointment alloc] initCancel];
    cancel.delegate = self;
    cancel.tag = JiangBinTag;
    [cancel cancelJiangBinAppointmentByOpaId:opaID];
    
}
#pragma mark - TableView Delegate & DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[self tableView:tableView  cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex ] count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    appRecordModel *model = [[patientAppRecordTableArray  objectAtIndex: segmemtControl.selectedSegmentIndex] objectAtIndex:section];
    return model.apptDate;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"单击取消状态取消预约，取消后预约作废，请重新预约";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    appointRecordCell *cell = [appointRecordCell reuseableCell:tableView withOwner:nil];
    NSArray *title = [NSArray arrayWithObjects:@"医生姓名:",@"预约科室:",@"预约时间:",@"预约编码:",@"预约号码:",@"取消状态:", nil];
    cell.titleLabel.text = [title objectAtIndex:indexPath.row];
    appRecordModel *model = [[patientAppRecordTableArray  objectAtIndex: segmemtControl.selectedSegmentIndex] objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        cell.contentLabel.text = model.doctorName;
    }
    else if(indexPath.row==1){
        cell.contentLabel.text = model.deptName;
    }
    else if (indexPath.row==2){
        cell.contentLabel.text = model.apptTime;
    }
    else if(indexPath.row == 3){
        cell.contentLabel.text = model.opaID;
    }
    else if(indexPath.row==4){
        cell.contentLabel.text = model.ticketNo;
    }
    else if(indexPath.row==5){
        cell.contentLabel.textColor = [UIColor brownColor];
        cell.contentLabel.text = [model.cancelFlag integerValue]== 0?@"未取消":@"已取消";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appRecordModel *model = [[patientAppRecordTableArray  objectAtIndex: segmemtControl.selectedSegmentIndex] objectAtIndex:indexPath.section];

    opaID = [[NSString alloc] initWithString:model.opaID];
    self.selectedIndexPath = indexPath;
    if (indexPath.row==5&&[model.cancelFlag integerValue]==0) {
        // 取消预约
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定取消吗？" message:@"取消后预约作废，不可撤销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
@end
