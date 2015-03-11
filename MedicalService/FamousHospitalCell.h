//
//  HospitalViewController.h
//  MedicalService
//
//  Created by view on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamousHospitalCell : FLtableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellGrageLabel;

@end
