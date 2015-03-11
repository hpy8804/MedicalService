//
//  FLDefines.h
//  FLService
//
//  Created by 张琼芳 on 13-8-1.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#ifndef testHelp_FLDefines_h
#define testHelp_FLDefines_h
#import "UIDevice+help.h"

//判断设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPOD ([[UIDevie model] isEuqalToString:@"iPod touch"])

#define IS_IPHONE5 [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f

#define IS_IPHONE_4_SCREEN [[UIScreen mainScreen] bounds].size.height >= 480.0f && [[UIScreen mainScreen] bounds].size.height < 568.0f

#define IS_IOS7 [[UIDevice currentDevice].systemVersion floatValue]>=7.0
//判断网络
#define IS_CONNETCTED_NEWWORK [UIDevice connectedToNetwork]

//是否显示navigationBar
#define SHOW_NAVAGATIONBAR(yesOrNo) self.navigationController.navigationBarHidden = !yesOrNo

//常用尺寸方法
#define ccr(t,l,w,h) CGRectMake(t,l,w,h)

#define ccp(x,y) CGPointMake(x,y)

#define ccs(w,h) CGSizeMake(w,h)

#define ccei(t,l,b,r) UIEdgeInsetsMake(t,l,b,r)


#endif
