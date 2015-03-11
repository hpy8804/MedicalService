//
//  searchList.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-15.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol searchListDelegate;

@interface searchList : NSObject

@property (nonatomic, strong) UIView *parentView;

@property (nonatomic, assign) id<searchListDelegate> delegate;

@property (nonatomic, assign) NSInteger tag;

-(id)initSearch;
#pragma mark - 康复医院
/**
 *  @brief 获取康复医院的搜索结果
 */
-(NSMutableArray *)getKangFuSearchResult;

/**
 *  @brief 请求康复医院的预约信息
 *
 *  @param hospitalCode 医院编码
 *  @param deptCode     科室编码
 *  @param Monday       开始日期
 *  @param Sunday       结束日期
 */
-(void)searchScheduleByDeparmentWithHospitalCode:(NSString *)hospitalCode deptCode:(NSString *)deptCode
                                          Monday:(NSString *)monday Sunday:(NSString *)sunday;
-(NSMutableArray *)getExpertSearchResult;

-(void)searchExpertScheduleWithHospitalCode:(NSString *)hospitalCode DeptCode:(NSString *)deptCode StartDate:(NSString *)startDate;
#pragma mark - 江滨医院

-(NSString *)getMessage;
/**
 *  @brief 获取江滨医院的搜索结果
 */
-(NSMutableArray *)getJiangBinSearchResult;

/**
 *  @brief 请求江滨医院的预约信息
 *
 *  @param hospitalCode 医院编码
 *  @param deptID       科室编码
 *  @param workDate     查询日期
 */
-(void)getSearchListWithHospitalCode:(NSString *)hospitalCode DeptId:(NSString *)deptID WorkDate:(NSString *)workDate;
@end

@protocol searchListDelegate <NSObject>

@optional

-(void)getSearchLishFinished:(searchList *)theSearchList;
-(void)JiangBinMessageFailed:(searchList *)theSearchList;
@end