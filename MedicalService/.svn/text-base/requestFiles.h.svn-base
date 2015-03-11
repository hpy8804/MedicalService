//
//  requestFiles.h
//  MedicalService
//
//  Created by 张琼芳 on 14-1-16.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weblink.h"

@protocol requestFilesDelegate;

@interface requestFiles : NSObject

@property(nonatomic,assign)NSInteger tag;

@property(nonatomic,assign)id<requestFilesDelegate> delegate;

-(void)requestBeginWithMethod:(FLHealthMethod)method Params:(NSArray *)params;

-(NSMutableArray *)responseArray;
@end

@protocol requestFilesDelegate <NSObject>

@optional
-(void)getFilesFinished:(requestFiles *)request;
-(void)getFilesFailed:(requestFiles *)request;

@end