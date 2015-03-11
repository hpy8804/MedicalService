//
//  hospitalModel.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-8.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "hospitalModel.h"

@implementation hospitalModel
@synthesize hospitalCode,hospitalName;
-(id)copyWithZone:(NSZone *)zone
{
    hospitalModel *newModel = [[hospitalModel allocWithZone:zone] init];
    newModel.hospitalCode = self.hospitalCode;
    newModel.hospitalName  = self.hospitalName;
    return newModel;
}
@end
