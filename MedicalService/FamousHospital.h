//
//  FamousHospital.h
//  MedicalService
//
//  Created by view on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamousHospital : UIViewController <UITableViewDataSource,UITableViewDelegate>{

    NSArray *_recommendHospitalArray;//存放了所有的“推荐医院”及其信息
    NSArray * _emphasisSubjectArray; //存放了所有“重点专科”及其信息
    NSArray *_cellImageArray; //存放医院照片的矩阵
    
    BOOL recommandHospitalBool;//是否选中“推荐医院”
    BOOL emphasisSubjectBool;//是否选中“重点专科”

}
@property (weak, nonatomic) IBOutlet UIButton *recommandHospitalButtom;
@property (weak, nonatomic) IBOutlet UIButton *emphasisSubjectButtom;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)recommandHospitalAction:(id)sender;
- (IBAction)emphasisSubjectAction:(id)sender;

@end
