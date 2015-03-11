//
//  getHospital.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "getHospital.h"

#import "NSString+block.h"

#import "SoapXmlParseHelper.h"

#import "GetXML.h"
#import "hospitalModel.h"

@interface getHospital ()<WebservicesDelegate>
{
    GetXML *xmlParser;
    Webservices *webservices;
}

@end
@implementation getHospital
@synthesize tag;
-(id)initForKangFu
{
    self = [self init];
    if (self) {
        hospitalKangFu = [[NSMutableArray alloc] init];
        
        webservices = [[Webservices alloc] init];
        webservices.delegate = self;
        webservices.tag = KangFuTag;
        [webservices requestKangFuWithMethodName:@"GetAllHospital" Params:nil Values:nil];
    }
    
    return self;
    
}
-(id)initForJiangBin
{
    self = [self init];
    if (self) {
        hospitalJiangBin = [[NSMutableArray alloc] init];
        
        webservices = [[Webservices alloc] init];
        webservices.delegate = self;
        webservices.tag = JiangBinTag;
        [webservices requestJiangBinWithMethodName:@"getHospitals" Params:nil Values:nil];
        
        
    }
    
    return self;
    
}
-(void)dealloc
{
    [super dealloc];
    hospitalJiangBin = nil;
    hospitalKangFu = nil;
    [hospitalKangFu release];
    [hospitalJiangBin release];
    xmlParser = nil;
    [xmlParser release];
    
}
#pragma  mark - 解析XML
-(NSMutableArray *)convertXMLString:(NSString *) string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlParser = [[GetXML alloc] init];
    xmlParser.parentView = self.parentView;
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code", @"msg", @"hospitalCode",@"hospitalName", nil];
    xmlParser.keyElements =[NSArray arrayWithObjects:@"code",@"msg",@"hospital", nil];
    [xmlParser parseWithData:data];
    
    return [xmlParser getFinalArray];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{

    if (theWebservice.tag==JiangBinTag) {
        // 江滨医院返回数据
        NSString *responseString = [theWebservice GetResponseString];
        responseString = [NSString cutForJiangBin:responseString];
        
        // 解析XML
        NSMutableArray *array = [self convertXMLString:responseString];
        
        for(NSDictionary *dic in array){
            hospitalModel *model = [[hospitalModel alloc] init];
            model.hospitalCode = [dic objectForKey:@"hospitalCode"];
            model.hospitalName = [dic objectForKey:@"hospitalName"];
            
            if (model.hospitalName!=nil) {
                
                [hospitalJiangBin addObject:model];
               

            }
            [model release];
        }
        
    }
    
    else{
        
        NSMutableArray *object = [theWebservice GetResponseArray];
        
        for(NSDictionary *dic in object){
            NSArray *array = [dic objectForKey:@"Hospital"];
            for(NSDictionary *dic in array){
                hospitalModel *model = [[hospitalModel alloc] init];
                model.hospitalName = [[[dic objectForKey:@"HospitalName"] objectAtIndex:0] objectForKey:@"text"];
                model.hospitalCode = [[[dic objectForKey:@"HospitalCode"] objectAtIndex:0] objectForKey:@"text"];
               
               
                [hospitalKangFu addObject:model];
                
                [model release];
                
            }
        }
    }
    if ([_delegate respondsToSelector:@selector(getValueFinished:)]) {
        [self.delegate getValueFinished:self];
    }
}

-(NSMutableArray *)JiangBinHospitals{
    return hospitalJiangBin;
}
-(NSMutableArray *)KangFuHospitals{
    return hospitalKangFu;
}
@end
