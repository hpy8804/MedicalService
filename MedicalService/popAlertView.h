//
//  popAlertView.h
//  
//
//  Created by eyas on 13-4-18.
//
//

#import <UIKit/UIKit.h>

@interface popAlertView : UIAlertView<UIPickerViewDelegate>{
    UIDatePicker *_datePicker;
    UIPickerView *_picker;
}
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIPickerView *picker;
-(void) CreateDatePickerView;
-(void) CreatePickerView;

@end
