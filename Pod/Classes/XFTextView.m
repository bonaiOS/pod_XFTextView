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

@end

@implementation XFTextView


- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.TV = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.TV.text = placeholder;
        self.TV.textColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:214/255.0 alpha:1];
        self.TV.font = [UIFont systemFontOfSize:15];
        self.TV.backgroundColor = [UIColor clearColor];
        self.TV.editable = NO;
        [self addSubview:self.TV];
        [self sendSubviewToBack:self.TV];
        self.delegate = self;
        _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
        _singleFingerPanRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:_singleFingerPanRecognizer];
        
        _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
        _doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:_doubleFingerPanRecognizer];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.text.length == 0) {
        self.TV.hidden = NO;
    }
    else {
        self.TV.hidden = YES;
    }
}


//- (id)init
//{
//    self = [super init];
//    if (self) {
//        _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
//        _singleFingerPanRecognizer.maximumNumberOfTouches = 1;
//        [self addGestureRecognizer:_singleFingerPanRecognizer];
//    
//        _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
//        _doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
//        [self addGestureRecognizer:_doubleFingerPanRecognizer];
//
//    }
//    return self;
//}




- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer
{
    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
}

- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
    NSRange selectedRange;
    if (cursorLocation > self.startRange.location)
    {
        selectedRange = NSMakeRange(self.startRange.location, fabs(self.startRange.location-cursorLocation));
    }
    else
    {
        selectedRange = NSMakeRange(cursorLocation, fabs(self.startRange.location-cursorLocation));
    }
    self.selectedRange = selectedRange;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



@end
