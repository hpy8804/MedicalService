//
//  HospitalWebView.m
//  MedicalService
//
//  Created by view on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "HospitalWebView.h"

@interface HospitalWebView ()

@end

@implementation HospitalWebView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        activity = [[FLActivity alloc] init];
         _htmlRecommendHospitalArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
        _htmEmphasisSubjectArray =
        [[NSArray alloc] initWithObjects:
         @"cardiology",//心内科
         @"traditionalchineseinternalmedicine",//中医内科
         @"braincenter",// 脑科中心
         @"ophthalmology",// 眼科
         @"liverdiseasebranch",// 肝病科
         @"dermatology",// 皮肤科
         @"criticalcaremedicine",// 重症医学科
         @"chestsurgical",// 脑外科
         @"orthopedics",// 骨科
         @"obstetricsandgynecology",// 妇产科
         @"GetWellSpecial",// 康复专科
         @"urologySpecialty",// 泌尿科
         @"obstetrics",// 产科
         @"childprotection",// 儿保科
         nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [activity startActivity:self.webView];
    
    //去掉ios7上的空白处
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.webView.autoresizesSubviews = YES;
    self.webView.scalesPageToFit = YES;
    //从NSBundle里加载路径,ofType 是后缀名
    if (_recomendHospitalHtmlBool) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[_htmlRecommendHospitalArray objectAtIndex:_HtmlIndex] ofType:@"html"];
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
    if (_emphsisHospitalHtmBool) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[_htmEmphasisSubjectArray objectAtIndex:_HtmlIndex] ofType:@"htm"];
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [activity stopActivity];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [activity stopActivity];
}

@end
