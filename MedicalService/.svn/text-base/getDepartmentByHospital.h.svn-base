//
//  getKangFuDepartment.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//
// 根据医院获取其科室信息

#import <Foundation/Foundation.h>

@protocol getDepartmentDelegate;
@interface getDepartmentByHospital : NSObject<WebservicesDelegate>
{
    NSMutableArray *KangFuDepartment;
    NSMutableArray *JiangBinDepartment;
    Webservices *webservice;
}
@property(nonatomic , assign)id<getDepartmentDelegate> delegate;

@property (nonatomic, assign)NSUInteger tag;

-(id)initKangFuWithValue:(NSString *)code;
-(id)initJiangBinWithValue:(NSString *)hospitalCode;
-(NSMutableArray *)getKangFuDepartment;
-(NSMutableArray *)getJiangBinDepartment;
@end
@protocol getDepartmentDelegate <NSObject>

@optional
-(void)getDepartmentFinished:(getDepartmentByHospital *)department;

@end