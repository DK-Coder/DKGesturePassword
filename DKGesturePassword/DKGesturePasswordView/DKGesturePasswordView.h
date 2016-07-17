//
//  DKGesturePasswordView.h
//  DKGesturePassword
//
//  Created by xuli on 16/7/12.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKGesturePasswordView : UIView

/**
 *  初始化手势密码界面
 *
 *  @param number 按钮个数
 *  @param color  线条颜色
 *
 *  @return
 */
- (instancetype)initWithButtonNumber:(NSInteger)number lineColor:(UIColor *)color;

/**
 *  初始化9个按钮的手势密码界面
 *
 *  @param color 线条颜色
 *
 *  @return 
 */
- (instancetype)initWithNineButtonWithLineColor:(UIColor *)color;

@property (nonatomic, strong) UIColor *lineColor;
@end
