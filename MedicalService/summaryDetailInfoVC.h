//
//  summaryDetailInfoVC.h
//  MedicalService
//
//  Created by 张琼芳 on 14-1-17.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface summaryDetailInfoVC : UIViewController
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,copy)NSDictionary *summaryDetail;
@property (strong, nonatomic) IBOutlet UITableView *summaryTable;
@end
