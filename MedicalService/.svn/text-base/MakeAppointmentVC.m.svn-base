//
//  MakeAppointmentVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-8.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "hospitalAppointVC.h"
#import "MakeAppointmentVC.h"
#import "hospitalModel.h"
#import "HospitalWebView.h"
@interface MakeAppointmentVC ()<WebservicesDelegate>


@end

@implementation MakeAppointmentVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title  = @"医疗集团";
         _htmlHospitalArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //去掉ios7上的空白处
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toHospitalAppointVC:(NSInteger)team
{
    // 跳转到预约界面
    hospitalAppointVC *appointVC = [[hospitalAppointVC alloc] initWithNibNameSupportIPhone5AndIPad:@"hospitalAppointVC"];
    appointVC.team = team;
    [self.navigationController pushViewController:appointVC animated:YES];
    [appointVC release];
}
- (IBAction)appointJiangBin:(id)sender {
    // 江滨医疗集团
    [self toHospitalAppointVC:JiangBinTag];
}

- (IBAction)appointKangFu:(id)sender {
    // 康复医疗集团
    [self toHospitalAppointVC:KangFuTag];
    
}

//江大附属医院
- (IBAction)subordinateHospitalButtom:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"江苏大学附属医院";
    hospitalWebView.HtmlIndex = 0;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];
}

//中医院
- (IBAction)tranditionHospitalButtom:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"镇江市中医院";
    hospitalWebView.HtmlIndex = 1;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];

}

//第三人民医院
- (IBAction)thirdHospital:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"镇江市第三人民医院";
    hospitalWebView.HtmlIndex = 2;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];

}

//第四人民医院
- (IBAction)fourthHospitalButtom:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"镇江市第四人民医院";
    hospitalWebView.HtmlIndex = 5;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];

}

//第二人民医院
- (IBAction)secondHospital:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"镇江市第二人民医院";
    hospitalWebView.HtmlIndex = 4;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];

}

//第一人民医院
- (IBAction)firstHospitalButtom:(id)sender {
    
    HospitalWebView *hospitalWebView = [[HospitalWebView alloc] init];
    hospitalWebView.title = @"镇江市第一人民医院";
    hospitalWebView.HtmlIndex = 3;
    hospitalWebView.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalWebView animated:YES];
    [ hospitalWebView release];

}
@end
