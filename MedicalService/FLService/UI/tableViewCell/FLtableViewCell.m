//
//  FLtableViewCell.m
//  FLService
//
//  Created by 张琼芳 on 13-8-2.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "FLtableViewCell.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

@implementation FLtableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (id)reuseableCell:(UITableView*)tableView WithCellIdentifier:(NSString *)cellIdentifier
{
    
    
    FLtableViewCell *cell;
    cell = (FLtableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FLtableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        
        cell = (FLtableViewCell *)[nibArray objectAtIndex:0];
        
    }
    
    return cell;
}
+ (id)reuseableCell:(UITableView*)tableView withOwner:(id)ownerOrNil
{
    
    NSString *CellIdentifier = NSStringFromClass([self class]);
    FLtableViewCell *cell = (FLtableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FLtableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        
        cell = (FLtableViewCell *)[nibArray objectAtIndex:0];

    }

    return cell;
}
@end
