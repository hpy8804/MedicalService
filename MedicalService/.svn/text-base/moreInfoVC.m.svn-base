//
//  moreInfoVC.m
//  MedicalService
//
//  Created by 张琼芳 on 14-1-17.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "moreInfoVC.h"

@interface moreInfoVC ()<UITableViewDataSource,UITableViewDelegate,requestFilesDelegate>
{
    UIButton *chooseButton;
    UIImageView *titleImage;
    FLActivity *activity;
    
    NSMutableArray *titleArray;
    NSMutableArray *valueArray;
    
    NSMutableArray *medicineInfoOfOutpatientValueArray;
    
    NSMutableArray *expenseInfoOfOutpatientValueArray;
    
    NSMutableArray *inspectionInfoOfOutpatientValueArray;

    // 住院用药信息
    NSMutableArray *medicineInfoInHospitalValueArray;
    
    // 住院费用信息
    NSMutableArray *expenseInfoInHospitalValueArray;
    
    NSMutableArray *inspectionInfoInHospitalValueArray;
    
    requestFiles *request;
    BOOL isSelected;
    UIView *grayView;
}
@end

@implementation moreInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleArray = [[NSMutableArray alloc] init];
        valueArray = [[NSMutableArray alloc] init];
        request = [[requestFiles alloc] init];
        activity = [[FLActivity alloc] init];
        
        medicineInfoOfOutpatientValueArray = [[NSMutableArray alloc] init];
        
        expenseInfoOfOutpatientValueArray= [[NSMutableArray alloc] init];
        
        inspectionInfoOfOutpatientValueArray = [[NSMutableArray alloc] init];
        
        medicineInfoInHospitalValueArray = [[NSMutableArray alloc] init];
        
        expenseInfoInHospitalValueArray= [[NSMutableArray alloc] init];
        
        inspectionInfoInHospitalValueArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNavigationItem];
    [self initSegment];
    [self setTitle];
    titleArray = [NSMutableArray arrayWithObjects:MEDICINE_TITLES,EXPENSE_TITLES,INSPECTION_TITLES,MEDICINE_TITLES,EXPENSE_TITLES,INSPECTION_TITLES, nil];

    isSelected = NO;
    
    [self requestBegin];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_segment removeFromSuperview];
}
-(void)initSegment
{
    _segment = [[UISegmentedControl alloc] initWithFrame:ccr(233, 7, 80, 29)];
    _segment.segmentedControlStyle = UISegmentedControlStyleBar;
    [_segment insertSegmentWithTitle:@"门诊" atIndex:0 animated:YES];
    
    [_segment insertSegmentWithTitle:@"住院" atIndex:1 animated:YES];
    
    [_segment addTarget:self action:@selector(outpatientOrInhospital:) forControlEvents:UIControlEventValueChanged];
   
    if (self.tag >3) {
        self.segment.selectedSegmentIndex = 1;
    }
    else{
        self.segment.selectedSegmentIndex = 0;
    }
    [self.navigationController.navigationBar addSubview:_segment];
    
}

-(void)initNavigationItem
{
    chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [chooseButton setTitleColor:IS_IOS7?[UIColor darkGrayColor]:[UIColor whiteColor] forState:UIControlStateNormal];
    chooseButton.titleLabel.textAlignment = NSTextAlignmentRight;
    titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    [titleImage setFrame:ccr(79, 15, 15, 15)];
    
    [chooseButton setFrame:ccr(5, 0, 75, 44)];
    
    [chooseButton addTarget:self action:@selector(chooseItem) forControlEvents:UIControlEventTouchUpInside];
    UIView *navigationTitleView = [[UIView alloc] initWithFrame:ccr(0, 0, 100, 44)];

    [navigationTitleView addSubview:titleImage];
    [navigationTitleView addSubview:chooseButton];
    self.navigationItem.titleView = navigationTitleView;
}
-(void)setTitle{
    
    NSArray *titles = [NSArray arrayWithObjects:@"用药信息",@"费用信息",@"检验检查", nil];
    
    [chooseButton setTitle:[titles objectAtIndex:self.tag%3] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chooseItem
{
    NSLog(@"choose");
    isSelected = !isSelected;
    if (isSelected) {
        [titleImage setImage:[UIImage imageNamed:@"up"]];
        [self addSelectViewInView];
    }
    else{
        [titleImage setImage:[UIImage imageNamed:@"down"]];
        [self dismissSelectView];
    }
    
    
}
-(void)addSelectViewInView
{
    self.selectView.layer.cornerRadius = 4.0;
    
    [self.selectView setFrame:ccr(5, -124, 310, 125)];
    grayView = [[UIView alloc] initWithFrame:ccr(0, 0, 320, 568)];
    grayView.backgroundColor = [UIColor darkGrayColor];
    grayView.alpha = 0;
    [self.view addSubview:grayView];
    [self.view addSubview:self.selectView];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    
    [self.selectView setFrame:IS_IOS7?ccr(5, 68, 310, 125):ccr(5, 1, 310, 125)];
    
    [grayView setAlpha:0.4];
    
    [UIView commitAnimations];
}
-(void)dismissSelectView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self.selectView setFrame:ccr(0, -124, 320, 124)];
    
    [grayView setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(removeSelectView) withObject:self afterDelay:0.5];
}
-(void)removeSelectView{
    [self.selectView removeFromSuperview];
    [grayView removeFromSuperview];
    
}
#pragma mark - request
-(void)requestBegin
{
    [activity startActivity:self.view];
    NSArray *param = [NSArray arrayWithObjects:self.medicalID, nil];
    request.delegate = self;
    
    request.tag = self.tag;
    NSInteger method[]= {medicineInfoOfOutpatient,
        expenseInfoOfOutpatient,
        inspectionInfoOfOutpatient,
        medicineInfoInHospital,// 住院用药信息
        expenseInfoInHospital,// 住院费用信息
        inspectionInfoInHospital,//住院检查信息
    };
    [request requestBeginWithMethod:method[self.tag] Params:param];
}
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
        [self handleTableValue:responseArray];
    }
    else{
        [self.view showToast:message];
        [self handleTableValue:nil];
    }

}
-(void)getFilesFailed:(requestFiles *)request
{
    [activity stopActivity];
    [self.view showToast:@"请求失败"];
}
-(void)handleTableValue:(NSMutableArray *)responseArray
{
//    NSLog(@"更多信息------%@",responseArray);
    NSArray *array = [NSArray arrayWithObjects:MEDICINE_KEYS,EXPENSE_KEYS,INSPECTION_KEYS,MEDICINE_KEYS,EXPENSE_KEYS,INSPECTION_KEYS, nil];
    NSArray *keys = [array objectAtIndex:self.tag];
    if ([valueArray count]>0) {
        [valueArray removeAllObjects];
    }
    
    for(NSDictionary *dictionary in responseArray){
        NSDictionary *data = [dictionary objectForKey:@"data"];
        if (data) {
            NSMutableArray *values = [[NSMutableArray alloc] init];
            for(NSString *key in keys)
            {
                NSString *value = [data objectForKey:key];
                value = value?value:@"不详";
                [values addObject:value];
            }
            [valueArray addObject:values];
        }
    }
    switch (self.tag) {
        case outPatientMedicineTag:
            medicineInfoOfOutpatientValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        case outpatientExpenseTag:
            expenseInfoOfOutpatientValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        case outpatientInspectionTag:
            inspectionInfoOfOutpatientValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        case hospitalMedicineTag:
            medicineInfoInHospitalValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        case hospitalExpenseTag:
            expenseInfoInHospitalValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        case hospitalInspectionTag:
            inspectionInfoInHospitalValueArray = [[NSMutableArray alloc] initWithArray:valueArray];
            break;
        default:
            break;
    }
    
    [self.moreInfoTable setDataSource:self];
    [self.moreInfoTable setDelegate:self];
    [self.moreInfoTable reloadData];
}
#pragma mark - table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [valueArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[valueArray objectAtIndex:section] count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (self.tag%3) {
        case outPatientMedicineTag:
            return [[valueArray objectAtIndex:section] objectAtIndex:2];
            break;
        case outpatientExpenseTag:
            return [[valueArray objectAtIndex:section] objectAtIndex:0];
            break;
        default:
            break;
    }
    
    return @"";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell标识符
    NSArray *identifiers = [NSArray arrayWithObjects:@"outpatientMedicineCell",@"outpatientExpenseCell",@"outpatientInspectionCell",@"inHospitalMedicineCell",@"inHospitalExpenseCell",@"inHospitalInspectionCell", nil];
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@%d",[identifiers objectAtIndex:tableView.tag],indexPath.row];
    // 取出复用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 初始化cell
    if (cell==Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = [[titleArray objectAtIndex:self.tag] objectAtIndex:indexPath.row];
    NSString *value = [[valueArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
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
- (IBAction)outpatientOrInhospital:(id)sender {
    if (self.tag>2) {
        self.tag = self.tag-3;
    }
    else {
        self.tag = self.tag+3;
    }
    [self setTitle];
    [self reloadValue];
    
}
- (IBAction)selectButtonClicked:(id)sender {
    isSelected = NO;
    [titleImage setImage:[UIImage imageNamed:@"down"]];
    [self dismissSelectView];
    UIButton *btn = (UIButton *)sender;
    if (self.tag==btn.tag||self.tag-3==btn.tag) {
        
        return;
    }
    else{
        self.tag = btn.tag+self.segment.selectedSegmentIndex*3;
        [self setTitle];
        
        [self reloadValue];
    }
}
-(void)reloadValue
{
    NSArray *array = [NSArray arrayWithObjects:medicineInfoOfOutpatientValueArray,expenseInfoOfOutpatientValueArray,inspectionInfoOfOutpatientValueArray,medicineInfoInHospitalValueArray,expenseInfoInHospitalValueArray,inspectionInfoInHospitalValueArray, nil];
    if (![[array objectAtIndex:self.tag] count]>0) {
        [self requestBegin];
        
    }
    else{
        valueArray = [array objectAtIndex:self.tag];
        [self.moreInfoTable reloadData];
    }
    
}
@end

