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
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self initAllControlls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAllControlls
{
    CGRect frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
//    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] initWithButtonNumber:12 lineColor:[UIColor blueColor]];
    DKGesturePasswordView *gesturePassword = [[DKGesturePasswordView alloc] initWithNineButton];
    gesturePassword.frame = frame;
//    gesturePassword.lineColor = [UIColor cyanColor];
    gesturePassword.lineWidth = 8.f;
    [gesturePassword gestureDrawComplete:^(NSString *password) {
        NSLog(@"%@", password);
    }];
    [self.view addSubview:gesturePassword];
}
@end
