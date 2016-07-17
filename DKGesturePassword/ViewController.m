//
//  ViewController.m
//  DKGesturePassword
//
//  Created by xuli on 16/7/12.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "ViewController.h"
#import "DKGesturePasswordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initAllControlls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAllControlls
{
    CGRect frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
//    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] init];
//    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] initWithFrame:frame];
//    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] initWithButtonNumber:9 lineColor:[UIColor blueColor]];
    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] initWithNineButtonWithLineColor:[UIColor blueColor]];
    gesturePassword.lineColor = [UIColor blueColor];
    gesturePassword.frame = frame;
    [self.view addSubview:gesturePassword];
}
@end
