//
//  PersonalServiceVC.m
//  MedicalService
//
//  Created by view on 13-8-23.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PersonalServiceVC.h"

#import "TPKeyboard.h"

#import "queryAppRecord.h"
#import "AppointRecord.h"

#import "KangFuAppointRecord.h"
#define KFirstLabel     ccr(35, 123, 93, 22)
#define KFirtTextField  ccr(125, 114, 165, 38)
#define KSecLabel       ccr(35, 180, 93, 22)
#define KSecTextField   ccr(125, 172, 165, 38)
#define KThirdLabel     ccr(35, 237, 93, 22)
#define KThirdTextField ccr(125,231,165,38)

#define KJiangBinButton ccr(100, 270, 120, 44)
#define KKangFuButton   ccr(100, 310, 120, 44)
@interface PersonalServiceVC ()<AppointRecordDelegate,kangFuAppointmentRecordDelegate>{
    queryAppRecord *queryRecord;
}

@end

@implementation PersonalServiceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        activity = [[FLActivity alloc] init];
        self.tag = KangFuTag;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameTextField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuName"]];
    [_phoneNumberTextField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuPhone"]];
    [_IDCardTextField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"KangFuIdNumber"]];
    
    self.title = @"查询预约";
    [self layOut:_nameTextField];
    [self layOut:_phoneNumberTextField];
    [self layOut:_IDCardTextField];
    
    if (IS_IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}
-(void)layOut:(UIView *)view{
    view.layer.cornerRadius = 7.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    queryRecord.delegate = nil;
    queryRecord = nil;
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [TPScrollView adjustOffsetToIdealIfNeeded];
    textField.layer.borderWidth = 2.0;
    
    textField.layer.borderColor = [[UIColor redColor] CGColor];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self layOut:textField];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        [self.phoneNumberTextField becomeFirstResponder];
    }
    else if(textField == self.phoneNumberTextField){
        [self.IDCardTextField becomeFirstResponder];
    }
    else if (textField == self.IDCardTextField){
        [textField resignFirstResponder];
    }
    return  YES;
}
- (IBAction)changeJiangbinOrKangfu:(id)sender {
    
    if (sender == _jiangBinButtom) {
        // 如果选中江滨集团，则让图案为选中状态，并让姓名栏消失
        self.tag = JiangBinTag;
        [_jiangBinButtom setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        [_kangFuButtom setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        
        // 让姓名栏消失，并让电话号码和身份证号栏坐标上移，重新调整
        [UIView animateWithDuration:0.4 animations:^{
            [[self.view viewWithTag:10]setHidden:YES];
            [_nameTextField setHidden:YES];
            
            _phomeNumberLabel.frame = KFirstLabel;
            _phoneNumberTextField.frame = KFirtTextField;
            _IDcardLabel.frame = KSecLabel;
            _IDCardTextField.frame = KSecTextField;
            _submitButton.frame = KJiangBinButton;
        }];
        _phoneNumberTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        _IDCardTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"IDNumber"];
        
    }
    if (sender == _kangFuButtom) {
        // 如果选中康复集团，则让图案为选中状态，并让姓名栏出现
        self.tag=KangFuTag;
        
        [_kangFuButtom setBackgroundImage:[UIImage imageNamed:@"radio_pressed"] forState:UIControlStateNormal];
        
        [_jiangBinButtom setBackgroundImage:[UIImage imageNamed:@"radio_unpressed"] forState:UIControlStateNormal];
        
        [[self.view viewWithTag:10] setFrame:ccr(35, 70, 93, 22)];
        
        [_nameTextField setFrame:ccr(123, 70, 165, 38)];
        
        [[self.view viewWithTag:10]setHidden:NO];
        
        [_nameTextField setHidden:NO];
        
        // 让姓名栏动画出现，并让电话号码和身份证号栏坐标下移，重新调整
        [UIView animateWithDuration:0.4 animations:^{
            [[self.view viewWithTag:10] setFrame:KFirstLabel];
            [_nameTextField setFrame:KFirtTextField];
            [_phomeNumberLabel setFrame:KSecLabel];
            [_phoneNumberTextField setFrame:KSecTextField];
            [_IDcardLabel setFrame:KThirdLabel];
            [_IDCardTextField setFrame:KThirdTextField];
            [_submitButton setFrame:KKangFuButton];
            
            
            
        }];
        
    }

}

- (IBAction)queryAppointment:(id)sender {
    if ([self checkTextField]) {
        return;
    }
    // 出现菊花
    [activity startActivity:self.view parentViewDisabled:YES];
    
    // 开始查询
    queryRecord = [[queryAppRecord alloc] initRecord];
    NSString *phone = self.phoneNumberTextField.text;
    NSString *IdNumber = self.IDCardTextField.text;
    NSString *name = self.nameTextField.text;
    // 江滨集团
    if (self.tag==JiangBinTag) {
        AppointRecord *recordVC = [[AppointRecord alloc] initWithNibNameSupportIPhone5AndIPad:@"AppointRecord"];
        recordVC.delegate = self;
        queryRecord.delegate = recordVC.recordDelegate;
        
        [queryRecord queryRecordByPhoneNumber:phone OrIdNumber:IdNumber];
    }
    else if(self.tag == KangFuTag){
        // 康复集团
        KangFuAppointRecord *kangFuRecord = [[KangFuAppointRecord alloc] initWithNibNameSupportIPhone5AndIPad:@"KangFuAppointRecord"];
        kangFuRecord.delegate = self;
        queryRecord.delegate = kangFuRecord.recordDelegate;
        [queryRecord searchAppointmentByPatientName:name Telephone:phone IDNumber:IdNumber];
    }
    
}
// 检查textFiled是否为空
-(BOOL)checkTextField
{
    [self.nameTextField resignFirstResponder];
    [self.IDCardTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    if (self.tag == KangFuTag) {
        // 判断姓名是否为空
        if (![self.nameTextField.text length]>0) {
            [self.view showToast:@"请填写姓名" withRect:ccr(130, 85, 100, 30)];
            // 为空则让其填写，并提示信息
            [self.nameTextField becomeFirstResponder];
            return YES;
        }
        
    }
    if (![self.phoneNumberTextField.text length]>0) {
        // 判断电话号码是否为空
        [self.view showToast:@"请填写电话号码" withRect:ccr(130,85,100,30)];
        // 为空则让其填写，并提示信息
        [self.phoneNumberTextField becomeFirstResponder];
        
        return YES;
    }
    if ([self.phoneNumberTextField.text length]<8) {
        [self.view showToast:@"电话号码填写不正确" withRect:ccr(130,85,100,30)];
        [self.phoneNumberTextField becomeFirstResponder];
        return YES;
    }
    if (![self.IDCardTextField.text length]>0) {
        // 判断身份证号是否为空
        [self.view showToast:@"请填写身份证号" withRect:ccr(130,20,120,30)];
        // 为空则让其填写，并提示信息
        [self.IDCardTextField becomeFirstResponder];
        
        return YES;
    }
    if ([self.IDCardTextField.text length]!=18) {
        [self.view showToast:@"身份证号填写不正确" withRect:ccr(130,20,120,30)];
        [self.IDCardTextField becomeFirstResponder];
        
        return YES;
    }
    return NO;

    
}
#pragma mark - delegate
-(void)queryAppointKangFuSucced:(KangFuAppointRecord *)theRecord
{
    [activity stopActivity];
    [[NSUserDefaults standardUserDefaults] setObject:self.nameTextField.text forKey:@"KangFuName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.IDCardTextField.text forKey:@"KangFuIdNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"KangFuPhone"];
    [self.navigationController pushViewController:theRecord animated:YES];
}
-(void)queryAppointKangFuFailed:(KangFuAppointRecord *)theRecord
{
    [activity stopActivity];
    [self.view showToast:@"查询失败" withRect:ccr(60, 250, 200, 30)];
}
-(void)getRecordFinished:(AppointRecord *)recordVC
{
    [activity stopActivity];
    [[NSUserDefaults standardUserDefaults] setObject:self.IDCardTextField.text forKey:@"IDNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phone"];
    [self.navigationController pushViewController:recordVC animated:YES];
}
-(void)getRecordFailed:(AppointRecord *)recordVC
{
    [activity stopActivity];
    [self.view showToast:recordVC.message withRect:ccr(40, 220, 250, 30)];
}
@end
