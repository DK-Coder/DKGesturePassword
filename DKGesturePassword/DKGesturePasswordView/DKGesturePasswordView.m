//
//  DKGesturePasswordView.m
//  DKGesturePassword
//
//  Created by xuli on 16/7/12.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKGesturePasswordView.h"

const int colsNumberPerRow = 3;

@interface DKGesturePasswordView()
{
    NSInteger _buttonNumber;
    UIColor *_lineColor;
    
    NSMutableArray *_arrayButtons;
    NSArray *_arraySelectedButtons;
}
@end

@implementation DKGesturePasswordView

- (instancetype)initWithButtonNumber:(NSInteger)number lineColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        _buttonNumber = number;
        _lineColor = color;
        
        [self sharedInit];
    }
    
    return self;
}

- (instancetype)initNineButtonWithLineColor:(UIColor *)color
{
    return [self initWithButtonNumber:9 lineColor:color];
}

- (void)sharedInit
{
    if (_buttonNumber % colsNumberPerRow != 0) {
        _buttonNumber = (_buttonNumber / colsNumberPerRow + 1) * colsNumberPerRow;
    }
    if (!_arrayButtons) {
        _arrayButtons = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < _buttonNumber; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTag:i + 1];
        [button setBackgroundColor:[UIColor yellowColor]];
        [button setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        [_arrayButtons addObject:button];
        [self addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGFloat widthForButton = CGRectGetWidth(frame) / (2.f * colsNumberPerRow + 1.f);
    for (UIButton *button in _arrayButtons) {
        NSInteger tag = [button tag];
        [button setFrame:CGRectMake(0.f, 0.f, widthForButton, widthForButton)];
        int rest = tag % colsNumberPerRow;
        if (rest == 0) {
            rest = colsNumberPerRow;
        }
        [button setCenter:CGPointMake(2 * rest - .5f, [self buttonY:tag])];
    }
}

- (CGFloat)buttonY:(NSInteger)buttonTag
{
    CGFloat y = 0;
    
    return y;
}
@end
