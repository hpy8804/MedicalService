//
//  getKangFuDepartment.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-9.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "getDepartmentByHospital.h"

#import "NSString+block.h"
#import "popAlertView.h"

#import "departmentModel.h"

#import "GetXML.h"

@interface getDepartmentByHospital ()
{
    GetXML *xmlParser;
}

@end

@implementation getDepartmentByHospital
@synthesize tag;
-(id) initKangFuWithValue:(NSString *)code
{
    self = [self init];
    if (self) {
    
        webservice = [[Webservices alloc] init];
        webservice.delegate = self;
        webservice.tag = KangFuTag;
        KangFuDepartment = [[NSMutableArray alloc] init];
        NSArray *params = [NSArray arrayWithObject:@"HospitalCode"];
        NSArray *values = [NSArray arrayWithObject:code];
        [webservice requestKangFuWithMethodName:@"GetAllDepartmentByHospital" Params:params Values:values];
        
    }
    return self;
}
-(id) initJiangBinWithValue:(NSString *)hospitalCode
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        webservice.delegate = self;
        webservice.tag = JiangBinTag;
        JiangBinDepartment = [[NSMutableArray alloc] init];
        NSArray *params = [NSArray arrayWithObject:@"arg0"];
        NSArray *values = [NSArray arrayWithObject:hospitalCode];
        [webservice requestJiangBinWithMethodName:@"getDepartments" Params:params Values:values];
        
    }
    return self;
    
}
-(NSMutableArray *)getJiangBinDepartment
{
    return JiangBinDepartment;
}
-(NSMutableArray *)getKangFuDepartment
{
    return KangFuDepartment;
}
-(NSMutableArray *)getXMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlParser = [[GetXML alloc] init];
   
    xmlParser.rootElements = [NSArray arrayWithObjects:@"code", @"msg", @"deptId",@"deptName",@"parentDeptId",@"deptType", nil];
    xmlParser.keyElements =[NSArray arrayWithObjects:@"code",@"msg",@"department", nil];
    [xmlParser parseWithData:data];
    
    return [xmlParser getFinalArray];
}
-(NSMutableArray *)getKangFuXMLString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    xmlParser = [[GetXML alloc] init];
    
    xmlParser.rootElements = [NSArray arrayWithObjects: @"DepartmentID",@"DepartmentName",@"ParentCode",@"deptType", nil];
    xmlParser.keyElements =[NSArray arrayWithObjects:@"Dept", nil];
    [xmlParser parseWithData:data];
    
    return [xmlParser getFinalArray];
}
-(void) WebservicesFinished:(Webservices *)theWebservice
{
    
    // 江滨医院的科室
    if (theWebservice.tag==JiangBinTag) {
        
        NSString *responseString = [theWebservice GetResponseString];
        
        responseString = [NSString cutForJiangBin:responseString];
        
        NSMutableArray *array = [self getXMLString:responseString];
        
        
        
        for(NSDictionary *dic in array){
            
            departmentModel *model = [[departmentModel alloc] init];
            
            model.DepartmentID = [dic objectForKey:@"deptId"];
            
            model.DepartmentName = [dic objectForKey:@"deptName"];
            
            model.DeptType = [dic objectForKey:@"deptType"];
            
            model.ParentCode = [dic objectForKey:@"parentDeptId"];
            
            if (model.DepartmentName!=nil) {
               
                [JiangBinDepartment addObject:model];
            }
            [model release];
        }
    }
    else if (theWebservice.tag == KangFuTag){
        
        NSMutableArray *object = [theWebservice GetResponseArray];
        for(NSDictionary *dic in object){
            
            NSArray *dept = [dic objectForKey:@"Dept"];
            for(NSDictionary *value in dept){
                departmentModel *model = [[departmentModel alloc] init];
                model.DepartmentID = [[[value objectForKey:@"DepartmentID"] objectAtIndex:0] objectForKey:@"text"];
                model.DepartmentName = [[[value objectForKey:@"DepartmentName"] objectAtIndex:0] objectForKey:@"text"];
                model.DeptType = [[[value objectForKey:@"DeptType"] objectAtIndex:0] objectForKey:@"text"];
                model.ParentCode = [[[value objectForKey:@"ParentCode"] objectAtIndex:0] objectForKey:@"text"];
                
                if (model.DepartmentName!=nil&&[model.DeptType integerValue]!=0) {
                    
                    [KangFuDepartment addObject:model];
                   
                }
                [model release];
                
            }
        }
    }
    if([_delegate respondsToSelector:@selector(getDepartmentFinished:)]){
        [self.delegate getDepartmentFinished:self];
    }

}
-(void)dealloc
{
    [super dealloc];
    webservice = nil;
    [webservice release];
    KangFuDepartment = nil;
    [KangFuDepartment release];
}
@end
