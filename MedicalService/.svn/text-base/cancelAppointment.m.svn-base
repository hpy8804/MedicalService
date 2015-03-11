//
//  cancelAppointment.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-26.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "cancelAppointment.h"
#import "NSString+block.h"
#import "GetXML.h"
@interface cancelAppointment ()<WebservicesDelegate>{
    Webservices *webservice;
    
}

@end

@implementation cancelAppointment
-(id)initCancel
{
    self = [self init];
    if (self) {
        webservice = [[Webservices alloc] init];
        webservice.delegate = self;
    }
    return self;
}
-(void)cancelJiangBinAppointmentByOpaId:(NSString *)opaID
{
    webservice.tag = JiangBinTag;
    NSArray *params = [NSArray arrayWithObject:@"arg0"];
    NSArray *values = [NSArray arrayWithObject:opaID];
    NSString *methodName = @"cancelAppointment";
    
    [webservice requestJiangBinWithMethodName:methodName Params:params Values:values];
}
-(void)cancelKangFUAppointmentByOrderStr:(NSString *)orderStr
{
    webservice.tag = KangFuTag;
    NSArray *params = [NSArray arrayWithObject:@"orderstr"];
    NSArray *values = [NSArray arrayWithObject:orderStr];
    NSString *methodName = @"CancelAppointment";
    [webservice requestKangFuWithMethodName:methodName Params:params Values:values];
}
-(void)WebservicesFinished:(Webservices *)theWebservice
{
    // 江滨集团取消预约返回值
    if (theWebservice.tag==JiangBinTag) {
        NSString *responseString = [theWebservice GetResponseString];
        if (responseString==nil&&[_delegate respondsToSelector:@selector(cancelFailed:)]) {
            [self.delegate cancelFailed:self];
            return;
        }
        responseString = [responseString spitStringByString:@"<return>"];
        responseString = [responseString spitToStringByString:@"</return>"];
       
        
        if ([responseString isEqualToString:@"<return>0"]&&[_delegate respondsToSelector:@selector(cancelSucced:)]) {
            [self.delegate cancelSucced:self];
        }
        else if ([responseString isEqualToString:@"<return>1"]&&[_delegate respondsToSelector:@selector(cancelFailed:)]){
            [self.delegate cancelFailed:self];
        }
    }
    // 康复集团取消预约返回值
    else if (theWebservice.tag == KangFuTag){
        NSMutableArray *object = [theWebservice GetResponseArray];
        
        
        if ([[object lastObject] isEqualToString:@"true"]&&[_delegate respondsToSelector:@selector(cancelSucced:)]) {
            [self.delegate cancelSucced:self];
        }
        else if ([[object lastObject] isEqualToString:@"false"]&&[_delegate respondsToSelector:@selector(cancelFailed:)]){
            [self.delegate cancelFailed:self];
        }
    }
}

@end
