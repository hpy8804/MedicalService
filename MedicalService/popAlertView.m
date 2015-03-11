//
//  popAlertView.m
//  MQViewer
//
//  Created by eyas on 13-4-18.
//
//

#import "popAlertView.h"

@implementation popAlertView

@synthesize datePicker=_datePicker;
@synthesize picker=_picker;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self CreateDatePickerView];
        
    }
    return self;
}
-(void) layoutSubviews
{
    for(UIView *view in self.subviews)
    {
        if(view.frame.size.height==43)
        {
            view.frame=CGRectMake(view.frame.origin.x, 232, 127, 43);
        }
    }
}
-(void) setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(0, 0, 320, 300)];
    self.center = CGPointMake(320/2, 250);
    
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)CreateDatePickerView
{
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _datePicker.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    _datePicker.frame = CGRectMake(10, 10, 300, 216);
    _datePicker.datePickerMode=UIDatePickerModeDate;
    [self addSubview:_datePicker];

}
-(void)CreatePickerView
{
    _picker = [[UIPickerView alloc]initWithFrame:CGRectZero];
    _picker.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    _picker.frame = CGRectMake(15, 10, 280, 216);
//    _picker.delegate = self;
//    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    [self addSubview:_picker];
    
}

//#pragma - mark pickerView
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return [[GlobalDetect sharedInstance].pickerArray count];
//}
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [[GlobalDetect sharedInstance].pickerArray objectAtIndex:row];
//}
@end
