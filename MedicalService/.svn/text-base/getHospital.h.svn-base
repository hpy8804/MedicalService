//
//  getHospital.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol getHospitalDelegate;
@interface getHospital : NSObject
{
    NSMutableArray *hospitalKangFu;
    NSMutableArray *hospitalJiangBin;
    
}
@property (nonatomic, assign) id<getHospitalDelegate> delegate;

@property (nonatomic, assign)NSUInteger tag;
@property (nonatomic, strong)UIView *parentView;
//请求康复集团的医院
-(id) initForKangFu;

//请求江滨集团的医院

-(id) initForJiangBin;

//获取江滨集团的医院

-(NSMutableArray *)JiangBinHospitals;

//获取康复集团的医院

-(NSMutableArray *)KangFuHospitals;


@end
#pragma mark - 代理
@protocol getHospitalDelegate <NSObject>

@optional

-(void)getValueFinished:(getHospital *)hospital;

@end
