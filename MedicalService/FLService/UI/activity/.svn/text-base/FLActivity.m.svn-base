//
//  FLActivity.m
//  FLService
//
//  Created by 张琼芳 on 13-8-2.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "FLActivity.h"
#import <QuartzCore/QuartzCore.h>

#define kDefaultMessage @"请稍等···"
@interface FLActivity ()

{
    UIView *activity;
    UIView *view;
}
@end

@implementation FLActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)initActivityWithMessage:(NSString *)message

{
    //初始化activity
    activity = [[UIView alloc] initWithFrame:CGRectMake(-300, -375, 1500, 1500)];
    
    activity.backgroundColor = [UIColor colorWithRed:80/255 green:80/255 blue:80/255 alpha:0.3];
    
    //设置圆角
    activity.layer.masksToBounds = YES;
    
    activity.layer.cornerRadius = 10.0;
    
    //添加一个indicator
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(16, 5, 37, 37)];
    activityView.color = [UIColor whiteColor];
    activityView.tag = 100;
    [activity addSubview:activityView];
    [activityView startAnimating];
    
    //添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 70, 22)];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont systemFontOfSize:13];
    
    label.numberOfLines = 2;
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = message;
    
    label.tag = 1000;
    
    [activity addSubview:label];
    
    [activity addSubview:activityView];
}

-(void)startActivity:(UIView *)parentView
{
    [self startActivity:parentView parentViewDisabled:NO];
    
}
-(void)startActivity:(UIView *)parentView parentViewDisabled:(BOOL)disabled
{
    
    [self initActivityWithMessage:kDefaultMessage];
    
    if (disabled) {
        
        view = [[UIView alloc] initWithFrame:ccr(0, 0, 320, 568)];
        
        view.backgroundColor = [UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:0.1];
        
        [parentView addSubview:view];
    }
    
    [parentView addSubview:activity];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    activity.backgroundColor = [UIColor colorWithRed:80/255 green:80/255 blue:80/255 alpha:0.8];
    activity.frame =CGRectMake(125, 150, 70, 70);
    [UIView commitAnimations];
    
}
-(void)stopActivity
{
    [view removeFromSuperview];
    [activity removeFromSuperview];
}
@end
