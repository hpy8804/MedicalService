//
//  UIView+toast.m
//  FLService
//
//  Created by 张琼芳 on 13-8-2.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "UIView+toast.h"
#import <QuartzCore/QuartzCore.h>
#define fDefaultRect CGRectMake(20,120,280,30)
#define fDefaultDurantion 0.75
@implementation UIView (toast)

-(void)showToast:(NSString*)text
{
    [self showToast:text withRect:fDefaultRect];
   
}
-(void)showToast:(NSString *)text withRect:(CGRect)rect
{
    [self showToast:text withRect:rect withDuration:fDefaultDurantion];
}

-(void)showToast:(NSString *)text withDuration:(NSTimeInterval)duration
{
    [self showToast:text withRect:fDefaultRect withDuration:duration];
}
-(void)showToast:(NSString *)text withRect:(CGRect)rect withDuration:(NSTimeInterval)duration
{
    //初始化一个View
    UIView *toastView =[[UIView alloc] initWithFrame:rect];
    
    toastView.backgroundColor = [UIColor blackColor];
    
    //设置view圆角
    toastView.layer.masksToBounds = YES;
    
    toastView.layer.cornerRadius = 6.0;
    
    toastView.layer.borderWidth = 0.5;
    
    toastView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    //初始化一个label
    UILabel *label = [[UILabel alloc] init];
    
    label.center = toastView.center;
    
    label.frame = CGRectMake(toastView.bounds.origin.x, toastView.bounds.origin.y, toastView.bounds.size.width, toastView.bounds.size.height);
    
    label.numberOfLines = 2;
    
    label.adjustsFontSizeToFitWidth = YES;
    
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text=text;
    
    //添加label到View上
    [toastView addSubview:label];
    
    [toastView setAlpha:0];
    
    [self addSubview:toastView];
    
    //设置动画
    [UIView animateWithDuration:fDefaultDurantion animations:^{[toastView setAlpha:1];} completion:^(BOOL finished){[UIView animateWithDuration:duration animations:^{[toastView setAlpha:0];}];}];
}

@end
