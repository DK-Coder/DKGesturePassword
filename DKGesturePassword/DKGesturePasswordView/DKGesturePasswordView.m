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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    
    return self;
}

- (instancetype)initWithButtonNumber:(NSInteger)number lineColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        _buttonNumber = number;
        _lineColor = color;
    }
    
    return self;
}

- (instancetype)initWithNineButtonWithLineColor:(UIColor *)color
{
    return [self initWithButtonNumber:9 lineColor:color];
}

- (void)sharedInit
{
    NSAssert(_buttonNumber % colsNumberPerRow == 0, @"按钮数量必须为3的整数倍");
    _buttonNumber = _buttonNumber != 0 ? : 9;
    if (!_arrayButtons) {
        _arrayButtons = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < _buttonNumber; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTag:i + 1];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:[NSString stringWithFormat:@"%d", (int)button.tag] forState:UIControlStateNormal];
        
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
        [button.layer setCornerRadius:widthForButton / 2.f];
        int rest = tag % colsNumberPerRow;
        if (rest == 0) {
            rest = colsNumberPerRow;
        }
        [button setCenter:CGPointMake((2 * rest - .5f) * widthForButton, [self buttonY:button])];
    }
}

- (CGFloat)buttonY:(UIButton *)button
{
    CGFloat y = 0;
    NSInteger tag = button.tag;
    NSInteger whichRow = (tag - 1) / colsNumberPerRow + 1;/**< 计算该按钮在哪一行*/
    y = CGRectGetHeight(self.frame) * .5f - ((2 * _buttonNumber / colsNumberPerRow) - 1) / 14.f * CGRectGetWidth(self.frame) + ((2 * whichRow) - 1.5f) * button.frame.size.width;
    
    return y;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
}
@end
