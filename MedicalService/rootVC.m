//
//  rootVC.m
//  MedicalService
//
//  Created by 张琼芳 on 13-12-31.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "rootVC.h"
#import "MainVC.h"
#import "loginFileVC.h"
@interface rootVC ()

@end

@implementation rootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];

    backItem.title = @"返回主页";
   
    self.navigationItem.backBarButtonItem = backItem;

    
}
-(void)viewWillAppear:(BOOL)animated
{
    SHOW_NAVAGATIONBAR(NO);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MakeAppointment:(id)sender {
    SHOW_NAVAGATIONBAR(YES);
    _mainVC = [[MainVC alloc] initWithNibNameSupportIPhone5AndIPad:@"MainVC"];
    [self.navigationController pushViewController:_mainVC animated:YES];
}

- (IBAction)CheckFile:(id)sender {
    SHOW_NAVAGATIONBAR(YES);
    _loginVC = [[loginFileVC alloc] initWithNibNameSupportIPhone5AndIPad:@"loginFileVC"];
    [self.navigationController pushViewController:_loginVC animated:YES
     ];
}
@end
