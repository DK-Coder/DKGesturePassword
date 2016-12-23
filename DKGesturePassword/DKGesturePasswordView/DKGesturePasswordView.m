//
//  DKGesturePasswordView.m
//  DKGesturePassword
//
//  Created by xuli on 16/7/12.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKGesturePasswordView.h"

/**
 *  列数，每行有几个按钮
 */
const NSInteger COLS_NUMBER_PER_ROW = 3;

/**
 *  默认的按钮宽度
 */
const CGFloat DEFAULT_BUTTON_WIDTH = 64.f;

/**
 *  默认的线条宽度
 */
const NSInteger DEFAULT_LINE_WIDTH = 10.f;

@interface DKGesturePasswordView()
{
    NSInteger _buttonNumber;/**< 按钮数量*/
    
    CGFloat marginForX;/**< 每个按钮在X轴上的间距（包括按钮和边界的间距和按钮之间的间距）*/
    CGFloat marginForY;/**< 每个按钮在Y轴上的间距（只是按钮和边界的间距，Y轴上按钮和按钮之间的间距使用marginForX的值*/
    
    NSMutableArray *_arrayButtons;/**< 存放按钮的数组*/
    NSMutableArray *_arraySelectedButtons;/**< 存放手指划过的按钮*/
    CGPoint _currentLocation;/**< 手指现在所在的位置*/
    
    gestureCompleteBlock completeBlock;
}
@end

@implementation DKGesturePasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    
    return self;
}

- (instancetype)initWithButtonNumber:(NSInteger)number
{
    _buttonNumber = number;
    
    return [super init];
}

- (instancetype)initWithNineButton
{
    return [self initWithButtonNumber:9];
}

- (void)sharedInit
{
    NSAssert(_buttonNumber % COLS_NUMBER_PER_ROW == 0, @"按钮数量必须为3的整数倍");
    _buttonNumber = _buttonNumber ? : 9;
    self.buttonWidth = DEFAULT_BUTTON_WIDTH;
    self.lineWidth = DEFAULT_LINE_WIDTH;
    self.lineColor = [UIColor cyanColor];
    if (!_arrayButtons) {
        _arrayButtons = [[NSMutableArray alloc] init];
    }
    if (!_arraySelectedButtons) {
        _arraySelectedButtons = [[NSMutableArray alloc] init];
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureDetected:)];
    [self addGestureRecognizer:panGesture];
    
    for (int i = 0; i < _buttonNumber; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTag:i];
        [button setUserInteractionEnabled:NO];
        [button setBackgroundImage:[UIImage imageNamed:@"Node-Normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Node-Highlighted"] forState:UIControlStateHighlighted];
        
        [_arrayButtons addObject:button];
        [self addSubview:button];
    }
    self.backgroundColor = [UIColor clearColor];
}

- (void)gestureDrawComplete:(gestureCompleteBlock)block
{
    completeBlock = block;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 指定的宽度如果小于等于0 或者 宽度相加大于屏幕宽度 的情况下，指定宽度为默认宽度
    if (self.buttonWidth <= 0.f || self.buttonWidth * COLS_NUMBER_PER_ROW >= CGRectGetWidth(self.frame)) {
        self.buttonWidth = DEFAULT_BUTTON_WIDTH;
    }
    CGFloat rowNumber = _buttonNumber / COLS_NUMBER_PER_ROW;
    marginForX = (CGRectGetWidth(self.frame) - COLS_NUMBER_PER_ROW * self.buttonWidth) / (COLS_NUMBER_PER_ROW + 1);
    marginForY = (CGRectGetHeight(self.frame) - rowNumber * self.buttonWidth - (rowNumber - 1) * marginForX) / 2.f;
    for (UIButton *button in _arrayButtons) {
        [button setFrame:CGRectMake(0.f, 0.f, self.buttonWidth, self.buttonWidth)];
        [button.layer setCornerRadius:self.buttonWidth / 2.f];
        [button setCenter:CGPointMake([self buttonX:button], [self buttonY:button])];
    }
}

- (CGFloat)buttonX:(UIButton *)button
{
    CGFloat x = 0;
    NSInteger tag = [button tag];
    // 计算该按钮在哪一列
    NSInteger whichCol = tag % COLS_NUMBER_PER_ROW;
    x = marginForX * (whichCol + 1) + (whichCol + .5f) * self.buttonWidth;
    
    return x;
}

- (CGFloat)buttonY:(UIButton *)button
{
    CGFloat y = 0;
    NSInteger tag = button.tag;
    // 计算该按钮在哪一行
    NSInteger whichRow = tag / COLS_NUMBER_PER_ROW;
    y = marginForY + marginForX * whichRow + (whichRow + .5f) * self.buttonWidth;
    
    return y;
}

- (void)gestureDetected:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self];
    _currentLocation = location;
    
    UIButton *button = [self whichButtonContainsLocation:location];
    if (button && !button.highlighted) {
        button.highlighted = YES;
        [_arraySelectedButtons addObject:button];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSMutableString *userInputPassword = [[NSMutableString alloc] init];
        for (UIButton *button in _arraySelectedButtons) {
            button.highlighted = NO;
            [userInputPassword appendFormat:@"%d", (int)button.tag];
        }
        [_arraySelectedButtons removeAllObjects];
        completeBlock(userInputPassword);
    }
    
    [self setNeedsDisplay];
}

- (UIButton *)whichButtonContainsLocation:(CGPoint)location
{
    for (UIButton *button in _arrayButtons) {
        if (CGRectContainsPoint(button.frame, location)) {
            return button;
        }
    }
    
    return nil;
}

-(void)drawRect:(CGRect)rect
{
    if (_arraySelectedButtons.count > 0) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int i = 0; i < _arraySelectedButtons.count; i++) {
            UIButton *button = _arraySelectedButtons[i];
            if (i == 0) {
                [path moveToPoint:button.center];
            } else {
                [path addLineToPoint:button.center];
            }
        }
        [path addLineToPoint:_currentLocation];
        [path setLineWidth:self.lineWidth != 0.f ? self.lineWidth : DEFAULT_LINE_WIDTH];
        [path setLineJoinStyle:kCGLineJoinRound];
        [self.lineColor set];
        [path stroke];
    }
}
@end
