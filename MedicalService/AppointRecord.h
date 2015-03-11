//
//  AppointRecord.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-24.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "queryAppRecord.h"

@protocol AppointRecordDelegate;
@interface AppointRecord : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    __weak IBOutlet UITableView *recordTableView;
    UISegmentedControl *segmemtControl;
    FLActivity *activity;
}
@property(nonatomic,assign)id<queryRecordDelegate> recordDelegate;
@property(nonatomic,assign)id<AppointRecordDelegate> delegate;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,retain)NSIndexPath *selectedIndexPath;
@end

@protocol AppointRecordDelegate <NSObject>

@optional
-(void)getRecordFinished:(AppointRecord *)recordVC;
-(void)getRecordFailed:(AppointRecord *)recordVC;

@end