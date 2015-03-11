//
//  UIViewController+help.m
//  testHelp
//
//  Created by 张琼芳 on 13-8-1.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "UIViewController+help.h"
#import "FLDefines.h"
@implementation UIViewController (help)

/**
 *  @brief  根据设备类型载入不同的xib文件（例如：iphone5则在nibNameOrNil后添加-iPhone5，ipad则在nibNameOrNil添加-iPad）  目前不同设备xib文件必须为：xxx-iPhone5.xib或xxx-iPad.xib或xxx-iPhone.xib
 *
 *  @param      nibNameOrNil    nib文件名（不带-iPhone5或-iPad或-iPhone）
 *
 *  @return                     对象
 *
 */
- (id)initWithNibNameSupportIPhone5AndIPad:(NSString *)nibNameOrNil{
    
    NSMutableString *nibName = [NSMutableString stringWithString:nibNameOrNil];
    
    if(IS_IPHONE5){
        [nibName appendFormat:@"-iPhone5"];
    }
    else if (IS_IPAD){
        [nibName appendFormat:@"-iPad"];
    }
    self = [self initWithNibName:nibName bundle:nil];
  
    return self;
}
@end
