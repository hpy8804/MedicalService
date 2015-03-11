//
//  web.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-7.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WebservicesDelegate;

@interface Webservices : NSObject
{
    NSString *responseString;
    NSMutableArray *responseArray;
    
}

@property (nonatomic, assign) id<WebservicesDelegate> delegate;

@property (nonatomic, assign) NSInteger tag;

//  @brief 获取得到的数据 
- (NSMutableArray *)GetResponseArray;
- (NSString *)GetResponseString;
#pragma mark - 网络请求

/**
 *  @brief 请求康复医院的数据
 *
 *  @param methodName       方法名
 *  @param propertyKeys     参数名(所有，存在一个数组中)
 *  @param propertyValues   参数值(所有，存在数组中，与参数名对应存放)
 */
-(void)requestKangFuWithMethodName:(NSString *)methodName Params:(NSArray *)propertyKeys Values:(NSArray *)propertyValues;
/**
 *  @brief 请求江滨医院的数据
 *
 *  @param methodName       方法名
 *  @param propertyKeys     参数名(所有，存在一个数组中,无参数则为nil)
 *  @param propertyValues   参数值(所有，存在数组中，与参数名对应存放,无参数为nil)
 */
-(void)requestJiangBinWithMethodName:(NSString *)methodName Params:(NSArray *)propertyKeys Values:(NSArray *)propertyValues;


@end

#pragma mark - 代理
@protocol WebservicesDelegate<NSObject>

@optional

-(void)WebservicesFinished:(Webservices *)theWebservice;

@end
