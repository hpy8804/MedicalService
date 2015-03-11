//
//  summaryDetailInfoVC.m
//  MedicalService
//
//  Created by 张琼芳 on 14-1-17.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "summaryDetailInfoVC.h"

#import "moreInfoVC.h"
@interface summaryDetailInfoVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSArray *titleArray;
    NSMutableArray *valueArray;
    
    NSString *medicalSummaryID;
}
@end

@implementation summaryDetailInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleArray =[[NSArray alloc]init];
        valueArray = [[NSMutableArray alloc] init];
        medicalSummaryID = [[NSString alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *navigationTitle = [NSArray arrayWithObjects:@"门诊摘要",@"住院摘要", nil];
    self.title = [navigationTitle objectAtIndex:self.tag];
    
    self.summaryTable.tag = self.tag;
    
    [self setNavigationBarButton];
    
    [self readyTable];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readyTable
{
    NSArray *keys = [NSArray array];
    if (self.tag==outPatientSummaryDetailTag) {
       titleArray = [[NSMutableArray alloc] initWithObjects:@"婚姻状况",@"就诊/住院机构",@"就诊/入院科室",@"就诊/入院日期",@"咨询问题",@"卫生服务要求",@"症状",@"发病时间",@"症状持续时间",@"诊断结果",@"诊断日期",@"健康问题评估",@"处置计划",@"其他医学处置",@"责任医师姓名",nil];
        keys = [NSArray arrayWithObjects:@"HYZKMC",@"JZJGMC",@"JZKSMC",@"JZRQSJ",@"ZXWT",@"WSFWYQ",@"ZZMC",@"FBRQSJ",@"ZZCXSJ",@"MZZDMC",@"MZZD_RQ",@"JKWTPG",@"CZJH",@"QTYXCZ",@"ZRYSXM",nil];
    }
    else if(self.tag == hospitalSummaryDetailTag){
        titleArray = [[NSMutableArray alloc] initWithObjects:@"婚姻状况",@"就诊/住院机构",@"就诊/入院科室",@"就诊/入院日期",@"住院原因",@"症状",@"发病时间",@"症状持续时间",@"诊断结果",@"诊断日期",@"其他医学处置",@"转诊标志",@"责任医师姓名",@"康复措施指导",@"住院者疾病",@"出院诊断",@"出院诊断日期",@"治疗结果",@"出院日期",nil];
        keys = [NSArray arrayWithObjects:@"HYZKMC",@"JZJGMC",@"JZKSMC",@"JZRQSJ",@"ZYYYMC",@"ZZMC",@"FBRQSJ",@"ZZCXSJ",@"RYZDMC",@"RYZD_RQ",@"QTYXCZ",@"ZZBZ",@"ZRYSXM",@"KFCSZD",@"ZYZJBZZMC",@"CYZDMC",@"CYZDRQ",@"ZLJGMC",@"CYRQ",nil];
    }
    medicalSummaryID = [self.summaryDetail objectForKey:@"YLZY_ID"];
    // 取出所有键值
    for (NSInteger index=0; index<[keys count]; index++)
    {
        NSString *key = [keys objectAtIndex:index];
        
        NSString *value = [self.summaryDetail objectForKey:key];
        
        value = value?value:@"不详";
        
        [valueArray addObject:value];
    }
    // 刷新table数据
    [self.summaryTable reloadData];

}
#pragma mark - navigationBar
-(void)setNavigationBarButton
{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStyleBordered target:self action:@selector(moreOperation)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}
-(void)moreOperation
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择操作" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"用药信息",@"费用信息",@"检验检查信息", nil];
    [sheet showInView:self.view];
}
#pragma mark - actionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    moreInfoVC *moreInformation = [[moreInfoVC alloc] initWithNibNameSupportIPhone5AndIPad:@"moreInfoVC"];
    
    if (self.tag==outPatientSummaryDetailTag) {
        moreInformation.tag = buttonIndex-1;
    }
    else if (self.tag == hospitalSummaryDetailTag) {
        moreInformation.tag = buttonIndex+2;
    }
    moreInformation.medicalID = medicalSummaryID;
    [self.navigationController pushViewController:moreInformation animated:YES];
}
#pragma mark - table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [valueArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell标识符
    NSArray *identifiers = [NSArray arrayWithObjects:@"outpatientSummaryCell",@"inHospitalSummaryCell", nil];
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@%d",[identifiers objectAtIndex:tableView.tag],indexPath.row];
    // 取出复用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 初始化cell
    if (cell==Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = [titleArray objectAtIndex:indexPath.row];
    NSString *value = [valueArray objectAtIndex:indexPath.row];
    // 设置cell上的值
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [value length]>0?value:@"不详";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:147.0/255.0 blue:248.0/255.0 alpha:1];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor darkTextColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
