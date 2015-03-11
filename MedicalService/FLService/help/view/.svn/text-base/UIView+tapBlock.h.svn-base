//
//  UIView+tapBlock.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-19.
//
//  扩展UIView 给UIView添加点击事件
//
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SGWhenTappedBlock)();

@interface UIView (tapBlock)<UIGestureRecognizerDelegate>

/**
 *  @brief  单次点击事件block调度
 *
 *  @param  block 调度函数
 *
 */
- (void)whenTapped:(SGWhenTappedBlock)block;
/**
 *  @brief  双击事件block调度
 *
 *  @param  block 调度函数
 *
 */
- (void)whenDoubleTapped:(SGWhenTappedBlock)block;

/**
 *  @brief  双指事件block调度
 *
 *  @param  block 调度函数
 *
 */
- (void)whenTwoFingerTapped:(SGWhenTappedBlock)block;

/**
 *  @brief  按下事件block调度
 *
 *  @param  block 调度函数
 *
 */
- (void)whenTouchedDown:(SGWhenTappedBlock)block;

/**
 *  @brief  弹起事件block调度
 *
 *  @param  block 调度函数
 *
 */
- (void)whenTouchedUp:(SGWhenTappedBlock)block;


@end
