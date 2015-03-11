//
//  GetXML.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-14.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetXML : NSObject

@property (nonatomic, strong)UIView *parentView;

// 需要解析的字段
@property (nonatomic, retain)NSArray *rootElements;

// 以这些关键字 为节点加入数组
@property (nonatomic, retain)NSArray *keyElements;

@property (nonatomic, copy)NSArray *propertyElements;

-(void)parseWithData:(NSData *)responseData;

-(NSMutableArray *)getFinalArray;
@end
