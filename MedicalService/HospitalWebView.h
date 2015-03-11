//
//  HospitalWebView.h
//  MedicalService
//
//  Created by view on 13-8-20.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalWebView : UIViewController<UIWebViewDelegate>{

    FLActivity *activity;
    BOOL done;
    NSArray *_htmlRecommendHospitalArray;//用来存放“推荐医院”的html
    NSArray *_htmEmphasisSubjectArray;//用来存放“终点专科”的htm
    

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic , assign) NSInteger HtmlIndex;//用于页面间传递参数使用
@property (nonatomic , assign) BOOL recomendHospitalHtmlBool;//"推荐医院"的bool
@property (nonatomic , assign) BOOL emphsisHospitalHtmBool;//"终点专科"bool

@end
