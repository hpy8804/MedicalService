//
//  GetXML.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-14.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "GetXML.h"

@interface GetXML ()<NSXMLParserDelegate>
{
    NSXMLParser *xmlParser;
    
        
    NSString *currentElement;
    
    NSString *currentValue;
    
    NSMutableDictionary *rootDic;
    
    NSMutableArray *finalArray;
    
    NSMutableArray *secondArray;
}

@end

@implementation GetXML

-(void)parseWithData:(NSData *)responseData
{
    
    
    xmlParser = [[NSXMLParser alloc] initWithData:responseData];
    
    xmlParser.delegate = self;
    BOOL flag = [xmlParser parse];
    if (flag) {
        [self.parentView showToast:@"开始解析"];
    }
    else{
        [self.parentView showToast:@"解析出错"];
    }

}

-(NSMutableArray *)getFinalArray
{
    return finalArray;
}
#pragma mark - XML Delegate

#pragma - mark 开始解析时
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    // 用数组存储每一组信息
    finalArray = [[NSMutableArray alloc] init];
    
    
}
#pragma - mark 发现节点时
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    for(NSString *key in self.keyElements){
        if ([elementName isEqualToString:key]) {
            rootDic = nil;
            
            rootDic = [[NSMutableDictionary alloc] initWithCapacity:0];
            
        }
        else {
            for(NSString *element in self.rootElements){
                if ([element isEqualToString:element]) {
                    currentElement = elementName;
                    currentValue = [NSString string];
                }
            }
        }
    }
    
}
#pragma - mark 发现节点值时

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if (currentElement) {
       // NSLog(@"%@",string);
        currentValue = string;
        [rootDic setObject:string forKey:currentElement];
    }
    

    
}
#pragma - mark 结束节点时
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (currentElement) {
        [rootDic setObject:currentValue forKey:currentElement];
        currentElement = nil;
        currentValue = nil;
    }
    for(NSString *key in self.keyElements){
        if ([elementName isEqualToString:key]) {
//            NSLog(@"%@",rootDic);
            if (rootDic) {
                [finalArray addObject:rootDic];
            }
        }
    }
}
#pragma - mark 结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}
@end
