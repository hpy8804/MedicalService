//
//  KangFuAppointRecord.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-26.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "queryAppRecord.h"
@protocol kangFuAppointmentRecordDelegate;
@interface KangFuAppointRecord : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    __weak IBOutlet UITableView *recordTableView;
    
    UISegmentedControl *segmemtControl;
}

@property(nonatomic,assign)id<kangFuAppointmentRecordDelegate> delegate;
@property(nonatomic,assign)id<queryRecordDelegate> recordDelegate;
@property(nonatomic,retain)NSIndexPath *selectedIndexPath;
@end


@protocol kangFuAppointmentRecordDelegate <NSObject>

@optional
-(void)queryAppointKangFuSucced:(KangFuAppointRecord *)theRecord;
-(void)queryAppointKangFuFailed:(KangFuAppointRecord *)theRecord;

@end