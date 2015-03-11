//
//  loginFileVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-12-31.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "loginFileVC.h"
#import "TPKeyboard.h"

#import "personalInfoVC.h"

@interface loginFileVC ()<requestFilesDelegate>
{
    FLActivity *activity;
}
@end

@implementation loginFileVC

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    
    
    self.usernameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    self.passwordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (self.usernameTextField.text==nil) {
        [self.usernameTextField becomeFirstResponder];
    }
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIView *loginButton =[ self.view viewWithTag:10];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius =6.0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [activity stopActivity];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- UITextField Delegate
// textField代理方法，键盘弹出时调用
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 阻止键盘挡住输入框
    [_TPScrollView adjustOffsetToIdealIfNeeded];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
        [self login:nil];
    }else{
        
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

-(void)getFilesFailed:(requestFiles *)request
{
    [activity stopActivity];
    
    [self.view showToast:@"网络错误，请稍后重试"];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}
// 网络请求回调函数
-(void)getFilesFinished:(requestFiles *)request
{
    // 停止转动
    [activity stopActivity];
    
    // 获取返回值
    NSMutableArray *array = [request responseArray];
    
    // 获取各级字典
    NSDictionary *head = [[array objectAtIndex:0] objectForKey:@"head"];
    
    // code值，为0成功，为1失败
    NSString *code = [head objectForKey:@"code"];
    
    // 返回消息
    NSString *message = [head objectForKey:@"msg"];
    
    //登陆成功
    if ([code isEqualToString:@"0"]) {
        
        // 存储用户名和密码，下次自动填充
        [[NSUserDefaults standardUserDefaults] setObject:self.usernameTextField.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
        
        // 显示登陆成功信息
        [self.view showToast:message withRect:ccr(20,self.view.frame.size.height-200,280,30)];
        
        // 跳转
        _personalView =[[personalInfoVC alloc] initWithNibNameSupportIPhone5AndIPad:@"personalInfoVC"];
       
        _personalView.tag = personalBasicInfoTag;
        [self.navigationController pushViewController:_personalView animated:YES];
    }
    else {
        //登陆失败
        
        [self.view showToast:message];
        [self.usernameTextField becomeFirstResponder];
        [activity stopActivity];

    }
}

// 登陆
- (IBAction)login:(id)sender {
    /*
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://my.ujs.edu.cn/userPasswordValidate.portal"]];
    [request setPostValue:@"30901040" forKey:@"Login.Token1"];
    [request setPostValue:@"15421214" forKey:@"Login.Token2"];
    request.delegate = self;
    [request startAsynchronous];
     */
 
    if (self.usernameTextField.text==nil) {
        [self.view showToast:@"用户名不可为空"];
        [self.usernameTextField becomeFirstResponder];
        return;
    }
    else if (self.passwordTextField.text==nil) {
        [self.view showToast:@"密码不可为空"];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    [activity startActivity:self.view parentViewDisabled:YES];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    requestFiles *login = [[requestFiles alloc] init];
    login.delegate = self;
    NSArray *params = [NSArray arrayWithObjects:self.usernameTextField.text,self.passwordTextField.text, nil];
    [login requestBeginWithMethod:loginRequest Params:params];
    
    
}

@end
