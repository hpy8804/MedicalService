//
//  UIDevice+help.m
//  FLService
//
//  Created by 张琼芳 on 13-8-1.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "UIDevice+help.h"
@implementation UIDevice (help)
/**
 *  @brief  设备名称
 *
 *  @return 名称字串
 */
+ (NSString*)name
{
    return [self currentDevice].name;
    
}

/**
 *  @brief  设备型号
 *
 *  @return 型号字串
 */
+ (NSString*)model{
    
    return [self currentDevice].model;
}
/**
 *  @brief  系统版本型号
 *
 *  @return 版本字串
 */
+ (NSString*)systemVersion
{
    return [self currentDevice].systemVersion;
}
/**
 *  @brief  系统版本名称
 *
 *  @return 版本名称字串
 */
+ (NSString*)systemName
{
    return [self currentDevice].systemName;
}
/**
 *  @brief  检测是否设备已连接网络
 *
 *  @return 是否已连接
 */
+ (BOOL)connectedToNetwork{
    
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断

    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}


@end
