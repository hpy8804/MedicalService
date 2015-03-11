//
//  MainVC.h
//  MedicalService
//
//  Created by 张琼芳 on 13-8-5.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFocusImageFrame.h"


@interface MainVC : UIViewController<SGFocusImageFrameDelegate,WebservicesDelegate>


#pragma - mark action
//挂号预约
- (IBAction)MakeAnAppointment:(id)sender;
//名医名院
- (IBAction)famousHospital:(id)sender;
//个人信息
- (IBAction)personalService:(id)sender;
//医院微博
- (IBAction)hospitalTwitter:(id)sender;
@end
