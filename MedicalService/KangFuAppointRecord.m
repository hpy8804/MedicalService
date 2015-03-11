//
//  KangFuAppointRecord.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-26.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "KangFuAppointRecord.h"

#import "appointRecordCell.h"
#import "appRecordModel.h"
#import "cancelAppointment.h"
@interface KangFuAppointRecord ()<queryRecordDelegate,cancelAppointmentDelegate>
{
    NSMutableArray  *patientAppRecordTableArray;
    NSString *orderStr;
    cancelAppointment *cancel;
   

}
@end

@implementation KangFuAppointRecord

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.recordDelegate = self;
        patientAppRecordTableArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.title = @"康复集团预约";
    
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initSegment];
    NSMutableArray *array =  patientAppRecordTableArray;
    NSMutableArray *uncancelArray = [NSMutableArray array];
    NSMutableArray *canceledArray = [NSMutableArray array];

    for(appRecordModelKangFu *model in array){
        if ([model.Status integerValue]==-1) {
            [canceledArray addObject:model];
        }
        else{
            [uncancelArray addObject:model];
        }
    }
    [patientAppRecordTableArray removeAllObjects];
    [patientAppRecordTableArray addObject:uncancelArray];
    [patientAppRecordTableArray addObject:canceledArray];
    


}
-(void)initSegment{
    segmemtControl = [[UISegmentedControl alloc] initWithFrame:ccr(100, 6.0, 150, 32)];
    [segmemtControl insertSegmentWithTitle:@"未取消" atIndex:0 animated:NO];
    [segmemtControl insertSegmentWithTitle:@"已取消" atIndex:1 animated:NO];
    segmemtControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmemtControl.selectedSegmentIndex = 0;
    [segmemtControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmemtControl];
}
-(IBAction)valueChanged:(id)sender
{
    [recordTableView reloadData];
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
// 根据日期升序排列
-(NSMutableArray *)startArraySort:(NSString *)keystring isAscending:(BOOL)isAscending Array:(NSArray *)array
{
    
    NSSortDescriptor *sortByA = [NSSortDescriptor sortDescriptorWithKey:keystring ascending:isAscending];
    
    NSMutableArray *result = [NSMutableArray  arrayWithArray:[array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByA,nil]]];
    return result;
    
}
#pragma mark - queryRecordDelegate
-(void)RequestPatientFinished:(queryAppRecord *)record
{
    patientAppRecordTableArray = [record getRecordArray];
    patientAppRecordTableArray = [self startArraySort:@"SliceStartTime" isAscending:NO Array:patientAppRecordTableArray];
    if ([patientAppRecordTableArray count]>0&&[_delegate respondsToSelector:@selector(queryAppointKangFuSucced:)]) {
        [self.delegate queryAppointKangFuSucced:self];
    }
    [record release];

}
-(void)RequestPatientFailed:(queryAppRecord *)record
{
    if ([_delegate respondsToSelector:@selector(queryAppointKangFuFailed:)]) {
        [self.delegate queryAppointKangFuFailed:self];
    }
}
#pragma mark - cancelAppointmentDelegate
-(void)cancelSucced:(cancelAppointment *)cancelRequest
{
    // 取消成功
    [self.view showToast:@"取消预约成功"];
    
    appointRecordCell *cell = (appointRecordCell *)[recordTableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    cell.contentLabel.text = @"已取消";
}
-(void)cancelFailed:(cancelAppointment *)cancelRequest
{
    // 取消失败
    [self.view showToast:@"操作失败"];
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    // 取消预约
    cancel = [[cancelAppointment alloc] initCancel];
    cancel.delegate = self;
    [cancel cancelKangFUAppointmentByOrderStr:orderStr];
}
#pragma mark - TableView Delegate & DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[self tableView:tableView  cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] count]>0) {
        [self.view showToast:@"无相关预约"];
    }
    return [[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    appRecordModelKangFu *model = [[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] objectAtIndex:section];
    NSArray *array = [model.SliceStartTime componentsSeparatedByString:@" "];
   
    return [array objectAtIndex:0];
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"单击取消状态取消预约，取消后预约作废，请重新预约";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 58;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    appointRecordCell *cell = [appointRecordCell reuseableCell:tableView withOwner:nil];
    NSArray *title = [NSArray arrayWithObjects:@"科室名称:",@"医生名称:",@"预约号码:",@"预约时间:",@"预约单号:",@"取消状态:", nil];
    appRecordModelKangFu *model = [[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] objectAtIndex:indexPath.section];
    cell.titleLabel.text = [title objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.contentLabel.text = model.DeptName;
    }
    else if (indexPath.row==1){
        cell.contentLabel.text = [model.ExpertName length]>0?model.ExpertName:@"-";
    }
    else if (indexPath.row==2){
        cell.contentLabel.text = model.RegisterNumber;
    }
    else if (indexPath.row==3){
        cell.contentLabel.text = model.SliceStartTime;
    }
    else if (indexPath.row==4){
        [cell.contentLabel adjustsFontSizeToFitWidth];
        cell.contentLabel.text = model.OrderId;
        cell.contentLabel.font = [UIFont boldSystemFontOfSize:11];
    }
    else if (indexPath.row==5){
        cell.contentLabel.textColor = [UIColor brownColor];
        cell.contentLabel.text = [model.Status integerValue]==-1?@"已取消":@"未取消";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appRecordModelKangFu *model = [[patientAppRecordTableArray objectAtIndex:segmemtControl.selectedSegmentIndex] objectAtIndex:indexPath.section];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if (indexPath.row==5&&[model.Status integerValue]!=-1) {
        orderStr = [[NSString alloc] initWithString:model.OrderId];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定取消吗？" message:@"取消后不可撤销，如需再约，请重新预约" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
@end
