//
//  loginFileVC.h
//  MedicalService
//
//  Created by 张琼芳 on 13-12-31.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboard;
@class personalInfoVC;
@interface loginFileVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) personalInfoVC *personalView;
@property (strong, nonatomic) IBOutlet TPKeyboard *TPScrollView;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)login:(id)sender;

@end
