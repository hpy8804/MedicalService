//
//  MainVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-5.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "MainVC.h"
#import "getDepartmentByHospital.h"

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

#import "MakeAppointmentVC.h"
#import "FamousHospital.h"
#import "PersonalServiceVC.h"
#import "weiboListVC.h"
#import "HospitalWebView.h"
#define mTitle @"预约诊疗"
@interface MainVC ()
{
    Webservices *webservice;
}
@end

@implementation MainVC

#pragma - mark life Cycle 生命周期方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        webservice = [[Webservices alloc] init];
        [self setBackButtonTilte:mTitle];
        
        [self setUpViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置标题
    self.title = mTitle;
    SHOW_NAVAGATIONBAR(YES);
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)dealloc
{
    [super dealloc];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark 设置返回键标题
-(void) setBackButtonTilte:(NSString *)title
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = title;
    
    self.navigationItem.backBarButtonItem = backItem;
    
    [backItem release];
}
#pragma  - mark 设置可动画的imageView
-(void)setUpViews
{
    //初始化图片的标题，图片的名字放在数组中
    NSArray *imageArray  = [NSArray arrayWithObjects:@"pic1.jpg", @"pic2.jpg", @"pic3.jpg", @"pic4.jpg", @"pic5.jpg", @"pic6.jpg", nil];
    NSArray *imageTitle = [NSArray arrayWithObjects:@"江苏大学附属医院", @"镇江市中医院", @"镇江市第三人民医院", @"镇江市第一人民医院", @"镇江市第二人民医院", @"镇江市第四人民医院", nil];
    NSMutableArray *imageItemArray = [NSMutableArray array];
    
    //批量初始化item
    for(NSInteger index = 0; index<6; index++){
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:[imageTitle objectAtIndex:index] image:[UIImage imageNamed:[imageArray objectAtIndex:index]] tag:index];
        [imageItemArray addObject:item];
    }
    
    //将这些图片放在页面上
    SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:ccr(12, 12, 296, 140) delegate:self focusItems:imageItemArray];
    
    [self.view addSubview:imageFrame];
    
}
#pragma mark - delegate
-(void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    
    [self showHospitalDetail:item.tag];
}
-(void)showHospitalDetail:(NSInteger)tag
{
    NSArray *array = [NSArray arrayWithObjects:@"江苏大学附属医院",@"镇江市中医院",@"镇江市第三人民医院",@"镇江市第一人民医院",@"镇江市第二人民医院",@"镇江市第四人民医院", nil];
    
    HospitalWebView *hospitalDetail = [[[HospitalWebView alloc] initWithNibNameSupportIPhone5AndIPad:@"HospitalWebView"]autorelease];
    hospitalDetail.title = [array objectAtIndex:tag] ;
    
    hospitalDetail.HtmlIndex = tag;
    hospitalDetail.recomendHospitalHtmlBool = YES;
    [self.navigationController pushViewController:hospitalDetail animated:YES];

}

#pragma mark - Action
- (IBAction)MakeAnAppointment:(id)sender {
    MakeAppointmentVC *appointVC = [[MakeAppointmentVC alloc] initWithNibNameSupportIPhone5AndIPad:@"MakeAppointmentVC"];
    [self.navigationController pushViewController:appointVC animated:YES];
    [appointVC release];
   
}

- (IBAction)famousHospital:(id)sender {
   
    FamousHospital *hospitalVC = [[FamousHospital alloc] initWithNibNameSupportIPhone5AndIPad:@"FamousHospital"];
    [self.navigationController pushViewController:hospitalVC animated:YES];
    [hospitalVC release];
    
}

- (IBAction)personalService:(id)sender {
    
    PersonalServiceVC *personalSerice = [[PersonalServiceVC alloc] initWithNibNameSupportIPhone5AndIPad:@"PersonalServiceVC"];
    [self.navigationController pushViewController:personalSerice animated:YES];
    [personalSerice release];
    
}

- (IBAction)hospitalTwitter:(id)sender {
    weiboListVC *listVC = [[weiboListVC alloc] initWithNibNameSupportIPhone5AndIPad:@"weiboListVC"];
    [self.navigationController pushViewController:listVC animated:YES];
    [listVC release];
}
@end
