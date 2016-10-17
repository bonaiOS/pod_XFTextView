//
//  XFTextView.m
//  FHProject
//
//  Created by Sun on 15/3/30.
//  Copyright (c) 2015年 Denxf. All rights reserved.
//

#import "XFTextView.h"

#define kCursorVelocity 1.0f/8.0f

@interface XFTextView ()
@property (nonatomic, strong) UIPanGestureRecognizer *singleFingerPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *doubleFingerPanRecognizer;
@property (nonatomic, assign) NSRange startRange;
@property (nonatomic,strong) NSString * str_placeholder;//placeholder

@end

@implementation XFTextView


- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {

        self.str_placeholder=placeholder;
        self.lab_placeholder=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 25)];
        self.lab_placeholder.font= [UIFont systemFontOfSize:15];
        self.lab_placeholder.text = placeholder;
        self.lab_placeholder.textColor=[UIColor grayColor];
        self.lab_placeholder.enabled = NO;//lable必须设置为不可用
        self.lab_placeholder.backgroundColor = [UIColor clearColor];
        [self addSubview:self.lab_placeholder];
        [self sendSubviewToBack:self.lab_placeholder];
        
        self.delegate = self;
      
//        _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
//        _singleFingerPanRecognizer.maximumNumberOfTouches = 1;
//        [self addGestureRecognizer:_singleFingerPanRecognizer];
//        
//        _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
//        _doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
//        [self addGestureRecognizer:_doubleFingerPanRecognizer];
    }
    return self;
}



//- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer
//{
//    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
//    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
//}
//
//- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender
//{
//    if (sender.state == UIGestureRecognizerStateBegan)
//    {
//        self.startRange = self.selectedRange;
//    }
//    
//    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
//    NSRange selectedRange = {cursorLocation, 0};
//    self.selectedRange = selectedRange;
//}
//
//- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender
//{
//    if (sender.state == UIGestureRecognizerStateBegan)
//    {
//        self.startRange = self.selectedRange;
//    }
//    
//    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
//    NSRange selectedRange;
//    if (cursorLocation > self.startRange.location)
//    {
//        selectedRange = NSMakeRange(self.startRange.location, fabs(self.startRange.location-cursorLocation));
//    }
//    else
//    {
//        selectedRange = NSMakeRange(cursorLocation, fabs(self.startRange.location-cursorLocation));
//    }
//    self.selectedRange = selectedRange;
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    if ([text isEqualToString:@"\n"]) {
    //        [textView resignFirstResponder];
    //        return NO;
    //    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (self.text.length==0) {
        self.lab_placeholder.hidden=NO;
    }
    else{
        self.lab_placeholder.hidden=YES;
    }
}


@end