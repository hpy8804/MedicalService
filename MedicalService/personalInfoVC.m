//
//  personalInfoVC.m
//  MedicalService
//
//  Created by 张琼芳 on 14-1-1.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "personalInfoVC.h"
#import "FLActivity.h"
#import "personalInfoCell.h"

#import "summaryDetailInfoVC.h"
#define KDefaultSubViewFrame ccr(0, 0, 320, 524)
#define KPickerOrginalFrame  ccr(0,568,320, 235)
#define KPickerFinalFrame    ccr(0,568-235,320, 235)
#define KPickerOrginalIOS6Frame ccr(0,480,320,235)
#define KPickerFinalIOS6Frame   ccr(0,480-235,320,235)

@interface personalInfoVC ()<requestFilesDelegate>
{
    //公用变量
  
    FLActivity *activity;
    requestFiles *fileRequest;
    NSString *patientMainIndex;
    NSString *medicalSummaryID;

    //个人档案 table数据源
    NSMutableArray *personalInfoTitleArray;
    NSMutableArray *personalInfoValueArray;
    
    // 个人补充信息 Table数据源
    NSMutableArray *personalExtraTitleArray;
    NSMutableArray *personalExtraValueArray;
    
    // 门诊
    NSMutableArray *outPatientSummaryListTitleArray;
    NSMutableArray *outPatientSummaryListValueArray;
    NSMutableArray *outpatientSummaryDetailValueArray;
    
    //住院 table数据源
    NSMutableArray *inHospitalSummaryListTitleArray;
    NSMutableArray *inHospitalSummaryListValueArray;
    NSMutableArray *inHospitalSummaryDetailValueArray;
    
    NSMutableArray *titleArray;
    NSMutableArray *valueArray;
 
}
@end

@implementation personalInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activity = [[FLActivity alloc] init];
        fileRequest = [[requestFiles alloc] init];
        
        // 个人信息Table

        personalInfoValueArray = [[NSMutableArray alloc] init];
        personalInfoTitleArray = [[NSMutableArray alloc] init];
        
        personalExtraTitleArray= [[NSMutableArray alloc] init];
        personalExtraValueArray= [[NSMutableArray alloc] init];
        
        outPatientSummaryListTitleArray  = [[NSMutableArray alloc] init];
        outPatientSummaryListValueArray  = [[NSMutableArray alloc] init];
        outpatientSummaryDetailValueArray= [[NSMutableArray alloc] init];

        inHospitalSummaryListTitleArray  = [[NSMutableArray alloc] init];
        inHospitalSummaryListValueArray  = [[NSMutableArray alloc] init];
        inHospitalSummaryDetailValueArray= [[NSMutableArray alloc] init];
        
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [fileRequest setDelegate:self];
  
    self.title = @"个人信息";
    
    [self requestbegin];
 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 网络请求
// 请求成功回调
-(void)getFilesFinished:(requestFiles *)arequest
{
    // 停止转动
    [activity stopActivity];
    
    // 获取返回值
    NSMutableArray *responseArray = [arequest responseArray];
    
    // 获取标志值，是否请求到有效数据
    NSDictionary *head = [[responseArray objectAtIndex:0] objectForKey:@"head"];
    
    // 获取code和message
    NSString *code = [head objectForKey:@"code"];
    NSString *message = [head objectForKey:@"msg"];
    
    // code为0，请求成功
    if ([code isEqualToString:@"0"]) {
        // 准备table数据
        switch (arequest.tag) {
            case personalBasicInfoTag:
                // 个人基本信息
                [self getPersonalBasicInfoTableArray:responseArray];
                break;
            case personalExtraInfoTag:
                // 个人补充信息
                [self personalExtraInfoTableValue:responseArray];
                break;
            case outPatientSummaryListTag:
                [self getoutPatientValue:responseArray];
                break;
            case hospitalSummaryListTag:
                [self getInHospitalTableValue:responseArray];
                break;
            default:
                break;
        }
        
    }
    else {
        // 显示失败信息
        [self.view showToast:message];
        self.contentTable.tag = arequest.tag;
        [self.contentTable reloadData];
    }
}
-(void)getFilesFailed:(requestFiles *)arequest
{
    // 停止转动
    [activity stopActivity];
    [self.view showToast:@"请求失败"];
}
#pragma - mark 个人档案

//个人档案-开始请求
-(void)requestbegin
{
    [activity startActivity:self.view parentViewDisabled:YES];
    
    fileRequest.tag = personalBasicInfoTag;
    
    NSString *IDNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSArray *params = [NSArray arrayWithObjects:IDNumber, nil];
    
    [fileRequest requestBeginWithMethod:personalBasicInfo Params:params];
    
    
}

//个人档案- 准备Table上数据源
-(void)getPersonalBasicInfoTableArray:(NSMutableArray *)responseArray
{
    NSLog(@"个人档案---%@",responseArray);
    // 标题
    personalInfoTitleArray = [NSMutableArray arrayWithObjects:@"姓名",@"性别",@"出生日期",@"身份证号",@"医保卡号",@"本人电话",@"户籍标志",@"现住址",@"户籍地址",@"民族名称",@"ABO血型",@"Rh血型",@"婚姻状况",@"学历名称",@"职业类别",@"国籍",@"医疗保险",@"建档机构",@"建档人",@"责任医师",@"建档日期", nil];
    // 返回数据键值
    NSArray *keys = [NSArray arrayWithObjects:@"XM",@"XBMC",@"CSRQ",@"SFZHM",@"YBKH",@"BRDHHM",@"CZDZHJBZ",@"XZZ",@"HJDZ",@"MZMC",@"ABOXXMC",@"RhXXMC",@"HYZKMC",@"XLMC",@"ZYLBMC",@"GJMC",@"YLBXLBMC",@"JDJGMC",@"JDRYMC",@"ZRYSXM",@"JSRQ", nil];
    
    // 获取返回数据值
    NSDictionary *data = [[responseArray objectAtIndex:1] objectForKey:@"data"];
    
    /*--获取患者主索引值，后文请求时所需参数--*/
    patientMainIndex = [[NSString alloc] initWithString:[data objectForKey:@"HZZSY"]];
    
    // 将数据按键值逐个取出存入数组
    for (NSInteger index=0; index<[keys count]; index++)
    {
        
        NSString *value = [data objectForKey:[keys objectAtIndex:index]];
        
        value = value?value:@"不详";
        
        NSString *key = [keys objectAtIndex:index];
        
        // 户籍值，1为户籍，2为非户籍
        if ([key isEqualToString:@"CZDZHJBZ"]) {
            NSArray *array = [NSArray arrayWithObjects:@"户籍",@"非户籍", nil];
            value = [array objectAtIndex:[value integerValue]-1];
        }
        [personalInfoValueArray addObject:value];
    }
    
    // 加载table
    [self.contentTable setDelegate:self];
    [self.contentTable setDataSource:self];
    [self.contentTable reloadData];
    
}

#pragma mark - 个人补充信息
// 补充信息网络请求
-(void)requestPersonalExtraInfo
{
    // 菊花转
    [activity startActivity:self.view parentViewDisabled:YES];
    // 设置请求的tag值
    fileRequest.tag = personalExtraInfoTag;
    // 参数
    NSArray *param = [NSArray arrayWithObjects:patientMainIndex, nil];
    // 开始请求
    [fileRequest requestBeginWithMethod:personalExtraInfo Params:param];
}
// 处理补充信息table值
-(void)personalExtraInfoTableValue:(NSMutableArray *)responseArray
{
    // 标题值
    personalExtraTitleArray = [[NSMutableArray alloc] initWithObjects:@"暴露类别",@"家庭厨房排风设施类别",@"家庭燃料类型类别",@"家庭饮水类别",@"家庭厕所类别",@"家庭禽畜栏类别",@"新生儿使用",@"工作单位",@"工作单位电话号码",@"联系人姓名",@"联系人电话号码", nil];
    
    personalExtraValueArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 键值
    NSArray *keys = [NSArray arrayWithObjects:@"BLLBMC",@"JTCFPFSSLBMC",@"JTRLLXLBMC",@"JTYSLBMC",@"JTCSLBMC",@"JTQXLLBMC",@"CSYXZMBH",@"GZDWMC",@"GZDWDHHM",@"LXRXM",@"LXRDHHM", nil];
    
    // 获取返回数据值
    NSDictionary *data = [[responseArray objectAtIndex:1] objectForKey:@"data"];
    
    // 将数据按键值逐个取出存入数组
    for (NSInteger index=0; index<[keys count]; index++)
    {
        NSString *key = [keys objectAtIndex:index];
        
        NSString *value = [data objectForKey:key];
        
        value = value?value:@"不详";
        
        [personalExtraValueArray addObject:value];
    }
    // 刷新table
    self.contentTable.tag = personalExtraInfoTag;
    [self.contentTable reloadData];

}
#pragma mark - 门诊

-(void)requestOutpatient
{
    [activity startActivity:self.view parentViewDisabled:YES];
    // 开始请求
    
    fileRequest.tag = outPatientSummaryListTag;
   
    // 传参
    NSArray *param = [NSArray arrayWithObjects:patientMainIndex, nil];
    
    [fileRequest requestBeginWithMethod:summaryListInfoOfOupatient Params:param];
}
//准备门诊Table数据源
-(void)getoutPatientValue:(NSMutableArray *)responseArray
{
    for(NSDictionary *dictionary in responseArray){
        NSDictionary *data = [dictionary objectForKey:@"data"];
        if (data) {
            NSString *title = [data objectForKey:@"JZJGMC"];
            NSString *value = [data objectForKey:@"JZRQSJ"];
            
            if ([value length]>10) {
                value = [value substringToIndex:10];
            }
            title = title?title:@"无";
            value = value?value:@"无";
           
            [outPatientSummaryListTitleArray addObject:title];
        
            [outPatientSummaryListValueArray addObject:value];
            
            [outpatientSummaryDetailValueArray addObject:data];
        }
        
    }
   
   
    // 刷新table
    self.contentTable.tag = outPatientSummaryListTag;
    [self.contentTable reloadData];

}
#pragma mark - 住院
-(void)InhospitalRequest
{
    [activity startActivity:self.view parentViewDisabled:YES];
    
    fileRequest.tag = hospitalSummaryListTag;
    
    NSArray *array = [NSArray arrayWithObjects:patientMainIndex, nil];
    
    [fileRequest requestBeginWithMethod:summaryListInHospital Params:array];

}
// 准备住院Table数据源
-(void)getInHospitalTableValue:(NSMutableArray *)responseArray
{
    
    // 获取返回数据值
    for(NSDictionary *dictionary in responseArray){
        NSDictionary *data = [dictionary objectForKey:@"data"];
        if (data) {
            NSString *title = [data objectForKey:@"JZJGMC"];
            NSString *value = [data objectForKey:@"JZRQSJ"];
            
            if ([value length]>10) {
                value = [value substringToIndex:10];
            }
            title = title?title:@"无";
            value = value?value:@"无";
            
            [inHospitalSummaryListTitleArray addObject:title];
            
            [inHospitalSummaryListValueArray addObject:value];
            
            [inHospitalSummaryDetailValueArray addObject:data];
        }
        
    }
    
    self.contentTable.tag = hospitalSummaryListTag;
    [self.contentTable reloadData];
    

}


#pragma  mark - TableView Delegate & DataSource

// Table每个分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case personalBasicInfoTag:
            return [personalInfoValueArray count];
            break;
        case personalExtraInfoTag:
            return [personalExtraValueArray count];
            break;
        case outPatientSummaryListTag:
            return [outPatientSummaryListValueArray count];
            break;
        default:
            break;
    }
    return [inHospitalSummaryListValueArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *identifiers = [NSArray arrayWithObjects:@"personalInfoCell",@"personalExtraCell",@"outpatientSummaryListCell",@"inHospitalSummaryListCell", nil];
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@%d",[identifiers objectAtIndex:tableView.tag],indexPath.row];
    // 定义复用cell
    personalInfoCell *cell = [personalInfoCell reuseableCell:tableView WithCellIdentifier:cellIdentifier];
    
    titleArray = [[NSMutableArray alloc] init];
    valueArray = [[NSMutableArray alloc] init];
    
    [titleArray addObject:personalInfoTitleArray?personalInfoTitleArray:@""];
    [titleArray addObject:personalExtraTitleArray?personalExtraTitleArray:@""];
    [titleArray addObject:outPatientSummaryListTitleArray?outPatientSummaryListTitleArray:@""];
    [titleArray addObject:inHospitalSummaryListTitleArray?inHospitalSummaryListTitleArray:@""];
    
    [valueArray addObject:personalInfoValueArray?personalInfoValueArray:@""];
    [valueArray addObject:personalExtraValueArray?personalExtraValueArray:@""];
    [valueArray addObject:outPatientSummaryListValueArray?outPatientSummaryListValueArray:@""];
    [valueArray addObject:inHospitalSummaryListValueArray?inHospitalSummaryListValueArray:@""];
    
    // 设置cell样式
    if (IS_IOS7||self.tag==outPatientSummaryListTag) {
        cell.accessoryType     = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *tableTitle = [titleArray objectAtIndex:tableView.tag];
    NSArray *tableValue = [valueArray objectAtIndex:tableView.tag];
    // 得到即将显示在cell上的各个元素的值
    NSString *title = [NSString string];
    NSString *value = [NSString string];
    if (indexPath.row<[tableTitle count]) {
        title =[tableTitle objectAtIndex:indexPath.row];
    }
    
    if (indexPath.row<[tableValue count]) {
        value =[tableValue objectAtIndex:indexPath.row];
    }
    
    // 设置cell上各个元素的值
    cell.titleLabel.text = title;
    
    cell.textView.text = [value length]>0?value:@"不详";
    
    if (tableView.tag==personalBasicInfoTag) {
        if (indexPath.row==7||indexPath.row==8) {
            // 第12行显示地址，字符串比较长，调整cell高度
            cell.textView.frame = ccr(89, 7, 200, 70);
            cell.frame = ccr(0, 0, 320, 77);
        }
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 个人信息和补充信息界面不作操作
    if (tableView.tag==personalBasicInfoTag||tableView.tag==personalExtraInfoTag) {
        return;
    }
    //准备跳转到summary界面，摘要信息
    summaryDetailInfoVC *summaryVC = [[[summaryDetailInfoVC alloc] initWithNibNameSupportIPhone5AndIPad:@"summaryDetailInfoVC"] autorelease];
    // 门诊信息
    if (tableView.tag==outPatientSummaryListTag) {
        summaryVC.summaryDetail = [outpatientSummaryDetailValueArray objectAtIndex:indexPath.row];
        summaryVC.tag = outPatientSummaryDetailTag;
    }
    // 住院信息
    else if(tableView.tag == hospitalSummaryListTag){
        summaryVC.summaryDetail = [inHospitalSummaryDetailValueArray objectAtIndex:indexPath.row];
        summaryVC.tag = hospitalSummaryDetailTag;
    }
    // 跳转
    [self.navigationController pushViewController:summaryVC animated:YES];
    
}
#pragma mark - Button Action
- (IBAction)barButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self buttonOperation:button.tag];
}
- (void)buttonOperation:(NSInteger)requestType
{
    
    if (self.tag == requestType) {
         // 如果原本就是在本页面，则不作任何操作
        return;
    }
    // 标题
    NSArray *navigationTitle = [NSArray arrayWithObjects:@"个人信息",@"个人补充信息",@"门诊记录列表",@"住院记录列表", nil];
    
    self.title = [navigationTitle objectAtIndex:requestType];
   
    // 设置自身tag
    self.tag = requestType;
    // 设置table的tag值，在reload时根据tag值加载对应的内容
    self.contentTable.tag = requestType;
    
    // 根据tag值请求
    switch (requestType) {
        case personalExtraInfoTag:
            if (![personalExtraValueArray count]>0) {
                [self requestPersonalExtraInfo];
            }
            break;
        case outPatientSummaryListTag:
            if (![outPatientSummaryListValueArray count]>0) {
                [self requestOutpatient];
            }
            break;
        case hospitalSummaryListTag:
            if (![inHospitalSummaryListValueArray count]>0) {
                [self InhospitalRequest];
            }
            break;
        default:
            break;
    }
    // 刷新table值
    [self.contentTable reloadData];
    
}
@end