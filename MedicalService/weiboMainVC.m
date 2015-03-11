//
//  weiboMainVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-28.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "weiboMainVC.h"

@interface weiboMainVC ()<UIWebViewDelegate>

@end

@implementation weiboMainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activity = [[FLActivity alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.autoresizesSubviews = YES;
    self.webView.scalesPageToFit = YES;
    // Do any additional setup after loading the view from its nib.

    NSURLRequest *request = [NSURLRequest requestWithURL:self.weiboURL];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activity startActivity:self.webView parentViewDisabled:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopActivity];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activity stopActivity];
}
@end
