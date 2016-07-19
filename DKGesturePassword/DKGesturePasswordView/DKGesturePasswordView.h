//
//  DKGesturePasswordView.h
//  DKGesturePassword
//
//  Created by xuli on 16/7/12.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gestureCompleteBlock)(NSString *password);

@interface DKGesturePasswordView : UIView

/**
 *  初始化手势密码界面
 *
 *  @param number 按钮个数
 *
 *  @return
 */
- (instancetype)initWithButtonNumber:(NSInteger)number;

/**
 *  初始化9个按钮的手势密码界面
 *
 *  @param color 线条颜色
 *
 *  @return 
 */
- (instancetype)initWithNineButton;

/**
 *  按钮宽度，默认是64
 */
@property (nonatomic, assign) CGFloat buttonWidth;
/**
 *  线条宽度，默认是10
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  线条颜色，默认是cyanColor
 */
@property (nonatomic, strong) UIColor *lineColor;

- (void)gestureDrawComplete:(gestureCompleteBlock)block;
@end
