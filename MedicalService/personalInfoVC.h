//
//  personalInfoVC.h
//  MedicalService
//
//  Created by 张琼芳 on 14-1-1.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class medicalDocVC;
@interface personalInfoVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger tag;

@property (strong, nonatomic) IBOutlet UITableView *contentTable;//个人信息Table

- (IBAction)barButtonClicked:(id)sender;
@end
