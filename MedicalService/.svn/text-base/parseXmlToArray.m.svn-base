//
//  parseXmlToArray.m
//  MedicalService
//
//  Created by 张琼芳 on 14-1-16.
//  Copyright (c) 2014年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "parseXmlToArray.h"

@interface parseXmlToArray ()<NSXMLParserDelegate>
{
    NSXMLParser *xmlParser;
    NSString *currentElement;
    
    NSString *currentValue;
    
    NSMutableDictionary *rootDic;
    
    NSMutableArray *finalArray;
    
    NSMutableArray *secondArray;
}

@end

@implementation parseXmlToArray
-(NSMutableArray *)getXmlArray
{
    return finalArray;
}
-(void)parseXmlWithData:(NSData *)responseData
{
    xmlParser = [[NSXMLParser alloc] initWithData:responseData];
    
    xmlParser.delegate = self;
    BOOL flag = [xmlParser parse];
    if (flag) {
        NSLog(@"开始解析");
    }
    else{
        NSLog(@"解析出错");
    }
}
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    // 用数组存储每一组信息
    finalArray = [[NSMutableArray alloc] init];
    rootDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
}
#pragma - mark 发现节点时
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
//    NSLog(@"节点开始--%@",elementName);
    
    
    currentElement = elementName;
    
    currentValue = [NSString string];
    
}
#pragma - mark 发现节点值时

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"节点值---%@",string);
    if (currentElement) {
       
        currentValue = string;
//        [rootDic setObject:string forKey:currentElement];
    }
    
    
    
}
#pragma - mark 结束节点时
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (currentElement) {
//        NSLog(@"当前节点--%@",currentElement);
        [rootDic setObject:currentValue forKey:currentElement];
        currentElement = nil;
        currentValue = nil;
        
    }
    else {
        if (rootDic) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:rootDic forKey:elementName];
            
            [finalArray addObject:dic];
            
        }
        rootDic = nil;
        
        rootDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
    }
    
  
}
#pragma - mark 结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"结束\n%@",finalArray);
}

@end
