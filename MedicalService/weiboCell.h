//
//  weiboCell.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-28.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "FLtableViewCell.h"

@interface weiboCell : FLtableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
