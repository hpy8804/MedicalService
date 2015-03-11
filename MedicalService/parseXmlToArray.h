//
//  parseXmlToArray.h
//  MedicalService
//
//  Created by 张琼芳 on 14-1-16.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parseXmlToArray : NSObject
-(void)parseXmlWithData:(NSData *)responseData;

-(NSMutableArray *)getXmlArray;
@end
