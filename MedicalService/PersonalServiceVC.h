//
//  PersonalServiceVC.h
//  MedicalService
//
//  Created by view on 13-8-23.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboard;
@interface PersonalServiceVC : UIViewController<UITextFieldDelegate>
{
    FLActivity *activity;
    __weak IBOutlet TPKeyboard *TPScrollView;
}
@property (strong, nonatomic) IBOutlet UIButton *jiangBinButtom;
@property (strong, nonatomic) IBOutlet UIButton *kangFuButtom;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UILabel *phomeNumberLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *IDcardLabel;
@property (strong, nonatomic) IBOutlet UITextField *IDCardTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property(nonatomic,assign)NSInteger tag;

- (IBAction)changeJiangbinOrKangfu:(id)sender;

- (IBAction)queryAppointment:(id)sender;
@end
