//
//  NSString+block.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-13.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "NSString+block.h"

@implementation NSString (block)

+(NSString *)cutForJiangBin:(NSString *)string
{
   
    string = [string replaceString:@"&gt;" ByString:@">"];
    string = [string replaceString:@"&lt;" ByString:@"<"];
    string = [string spitStringByString:@"<result>"];
    string = [string spitToStringByString:@"</return>"];
    return string;
}

-(NSString *)spitStringByString:(NSString *)keyword
{
    
    NSRange range = [self rangeOfString:keyword];
    if (range.length>0) {
        NSString *string = [self substringFromIndex:range.location];
        return string;
    }
    
    return self;
}
-(NSString *)spitToStringByString:(NSString *)keyword
{
    
    NSRange range = [self rangeOfString:keyword];
    if (range.length>0) {
        NSString *string = [self substringToIndex:range.location];
        return string;
    }
    
    return self;
}
-(NSString *)replaceString:(NSString *) string ByString:(NSString *)replaceString
{
    return [self stringByReplacingOccurrencesOfString:string withString:replaceString];
}
@end
