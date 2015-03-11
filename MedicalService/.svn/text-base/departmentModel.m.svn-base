//
//  departmentModel.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "departmentModel.h"

@implementation departmentModel
@synthesize DepartmentID,DepartmentName,DeptType,ParentCode;

-(id)copyWithZone:(NSZone *)zone
{
    departmentModel *newModel = [[departmentModel allocWithZone:zone] init];
    
    newModel.DepartmentID = self.DepartmentID;
    newModel.DepartmentName = self.DepartmentName;
    newModel.DeptType = self.DeptType;
    newModel.ParentCode = self.ParentCode;
    
    return newModel;
}
@end
