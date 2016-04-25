//
//  XFTextView.h
//  FHProject
//
//  Created by Sun on 15/3/30.
//  Copyright (c) 2015年 Denxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFTextView : UITextView<UITextViewDelegate>

- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer;

@property (nonatomic) NSString *placeholder;
@property(nonatomic,strong) UILabel *lab_placeholder;

- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

@end
