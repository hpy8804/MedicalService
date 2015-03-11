//
//  FLActivity.h
//  FLService
//
//  Created by 张琼芳 on 13-8-2.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLActivity : UIView

/**
 * @param brief     开始转(如果在此过程中不希望界面被点击，调用下面的方法)
 * 
 * @param parentView  需要添加的view
 *
 */
-(void)startActivity:(UIView *)parentView;

/**
 * @param brief       开始转,添加带菊花的视图
 *
 * @param parentView  需要添加的view
 * @param disabled    是否禁止父类视图触摸
 **/
-(void)startActivity:(UIView *)parentView parentViewDisabled:(BOOL)disabled;
/**
 * @param brief     停止转动，并消失试图
 *
 **/
-(void)stopActivity;
@end
