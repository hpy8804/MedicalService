//
//  FLtableViewCell.h
//  FLService
//
/*自定义TableViewCell视图
*
*  用法：
*      在UITableView的cellForRowAtIndexPath委托函数中，调用静态reuseableCell函数即可
*      注意：
*          1、在reuseableCell中 已判断 tableview是否存在复用cell
*          2、自定义的tableviewcell，xib文件名必须和xxxTableViewCell.h一致。
*          （例如：FLHttpCustomTableViewCell.h和SGHttpCustomTableViewCell.m，那么xib文件名就必须是
*            FLHttpCustomTableViewCell.xib）
*/
//  Created by 张琼芳 on 13-8-2.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLtableViewCell : UITableViewCell


+ (id)reuseableCell:(UITableView *)tableView WithCellIdentifier:(NSString *)cellIdentifier;

/**
 *	@brief 复用TableViewCell
 *
 *	@param tableView
 *	@param ownerOrNil 拥有者，一般为nil
 *
 *	@returns 对象
 */
+ (id)reuseableCell:(UITableView *)tableView withOwner:(id)ownerOrNil;
@end
