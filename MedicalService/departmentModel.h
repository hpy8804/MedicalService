//
//  departmentModel.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface departmentModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *DepartmentID;
@property (nonatomic, copy) NSString *DepartmentName;
@property (nonatomic, copy) NSString *DeptType;
@property (nonatomic, copy) NSString*ParentCode;

@end
