//
//  FamousHospital.m
//  MedicalService
//
//  Created by view on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "FamousHospital.h"
#import "FamousHospitalCell.h"
#import "HospitalWebView.h"


@interface FamousHospital ()

@end

@implementation FamousHospital

#pragma mark - lifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
          _recommendHospitalArray = [[NSArray alloc] initWithObjects:@{@"name" :@"江苏大学附属医院",@"address":@"江苏省镇江市解放路438号",@"grade":@"三级甲等综合医院"}, @{@"name" :@"镇江市中医院",@"address":@"镇江市桃花坞路十区8号",@"grade":@"三级乙等中医医院"}, @{@"name":@"镇江市第三人民医院",@"address":@"镇江市润州区戴家门300号",@"grade":@"三级乙等中医医院"},@{@"name" :@"镇江市第一人民医院",@"address":@"江苏省镇江市电力路8号",@"grade":@"三级甲等综合医院"},@{@"name" :@"镇江市第二人民医院",@"address":@"镇江市南徐新城团山路18号",@"grade":@"二级甲等综合医院"},@{@"name" :@"镇江市第四人民医院",@"address":@"镇江市正东路20号",@"grade":@"三级甲等妇幼保健院"}, nil];
        
        _emphasisSubjectArray =
        [[NSArray alloc] initWithObjects:
         @{@"subject": @"心内科",@"hospital":@"江苏大学附属医院",@"grade":@"国家级临床重点专科"},
         @{@"subject": @"中医内科",@"hospital":@"江苏大学附属医院",@"grade":@"国家级临床重点专科"},
         @{@"subject": @"脑科中心",@"hospital":@"镇江市中医院",@"grade":@"市重点科室"},
         @{@"subject": @"眼科",@"hospital":@"镇江市中医院",@"grade":@"市重点科室"},
         @{@"subject": @"肝病科",@"hospital":@"镇江市第三人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"皮肤科",@"hospital":@"镇江市第三人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"重症医学科",@"hospital":@"镇江市第一人民医院",@"grade":@"国家级临床重点专科"},
         @{@"subject": @"胸外科",@"hospital":@"镇江市第一人民医院",@"grade":@"省重点专科"},
         @{@"subject": @"骨科",@"hospital":@"镇江市第二人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"妇产科",@"hospital":@"镇江市第二人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"康复专科",@"hospital":@"镇江市第二人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"泌尿科",@"hospital":@"镇江市第二人民医院",@"grade":@"市重点科室"},
         
         @{@"subject": @"产科",@"hospital":@"镇江市第四人民医院",@"grade":@"市重点科室"},
         @{@"subject": @"儿保科",@"hospital":@"镇江市第四人民医院",@"grade":@"市重点科室"}, nil];
        
        _cellImageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"pic1.jpg"],[UIImage imageNamed:@"pic2.jpg"],[UIImage imageNamed:@"pic3.jpg"],[UIImage imageNamed:@"pic4.jpg"],[UIImage imageNamed:@"pic5.jpg"],[UIImage imageNamed:@"pic6.jpg"], nil];
        
        recommandHospitalBool = YES;//默认是选中推荐医院
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"推荐医院";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (recommandHospitalBool) {
        
        return [_recommendHospitalArray count];
    }
    if (emphasisSubjectBool) {
        
        return [_emphasisSubjectArray count];
    }

    return -1;
}

#
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // static NSString * string1 = @"recommendHospital";
    static NSString *string2 = @"emphsisSubject";
    
    if (recommandHospitalBool) {
        
        FamousHospitalCell *cell = [FamousHospitalCell reuseableCell:tableView withOwner:nil];
        
            //设置cell的属性
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellImage.image = [_cellImageArray objectAtIndex:indexPath.row];
            cell.cellNameLabel.text = [[_recommendHospitalArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.cellAddressLabel.text = [[_recommendHospitalArray objectAtIndex:indexPath.row] objectForKey:@"address"];
            cell.cellGrageLabel.text = [[_recommendHospitalArray objectAtIndex:indexPath.row] objectForKey:@"grade"];
        
            return cell;
        
    }
    
    if (emphasisSubjectBool) {
    
        //不用封装的方法，使用自定义的cell 采用如下方法
        FamousHospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:string2];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FamousHospitalCell" owner:nil options:nil] lastObject];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cellImage.hidden = YES;
        
        //为了使用同一个cell 使其的frame 进行改变
        cell.cellNameLabel.frame = CGRectMake(13, 5, 175, 21);
        cell.cellAddressLabel.frame = CGRectMake(30, 27, 175, 21);
        cell.cellGrageLabel.frame = CGRectMake(30, 45, 175, 21);
        cell.cellNameLabel.text = [[_emphasisSubjectArray objectAtIndex:indexPath.row] objectForKey:@"subject"];
        cell.cellAddressLabel.text = [[_emphasisSubjectArray objectAtIndex:indexPath.row] objectForKey:@"hospital"];
        cell.cellGrageLabel.text = [[_emphasisSubjectArray objectAtIndex:indexPath.row] objectForKey:@"grade"];
        cell.frame = ccr(0, 0, 320, 70);
        return cell;
   }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HospitalWebView *webViewController = [[HospitalWebView alloc] init];
    
    if (recommandHospitalBool) {
    
        webViewController.title = [[_recommendHospitalArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        webViewController.HtmlIndex = indexPath.row;
        webViewController.recomendHospitalHtmlBool = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    if (emphasisSubjectBool) {
        
        webViewController.title = [[_emphasisSubjectArray objectAtIndex:indexPath.row] objectForKey:@"subject"];
        webViewController.emphsisHospitalHtmBool = YES;
        webViewController.HtmlIndex = indexPath.row;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
    
}

#pragma mark - 点击“推荐医院”，“重点专科"发生的事
- (IBAction)recommandHospitalAction:(id)sender {
    
    self.title = @"推荐医院";
    
    recommandHospitalBool = YES;
    emphasisSubjectBool = NO;
    [_tableView reloadData];
    
}

- (IBAction)emphasisSubjectAction:(id)sender {
    
    self.title = @"重点专科";
    recommandHospitalBool = NO;
    emphasisSubjectBool = YES;
    [_tableView reloadData];
}
@end
