//
//  ViewController.m
//  JYRoundPicker
//
//  Created by joyann on 15/10/27.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "ViewController.h"
#import "JYRoundPicker.h"

@interface ViewController ()
@property (nonatomic, weak) JYRoundPicker *roundPicker;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addRoundPicker];
    [self addButtons];
}

#pragma mark - Add Round Picker

- (void)addRoundPicker
{
    JYRoundPicker *roundPicker = [JYRoundPicker roundPicker];
    roundPicker.center = self.view.center;
    [self.view addSubview:roundPicker];
    self.roundPicker = roundPicker;
}

#pragma mark - Add Buttons

- (void)addButtons
{
    // 开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    startButton.frame = CGRectMake(self.roundPicker.frame.origin.x, self.roundPicker.frame.origin.y - 100, 100, 30);
    [startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    // 停止按钮
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [stopButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [stopButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    stopButton.frame = CGRectMake(CGRectGetMaxX(self.roundPicker.frame) - 100, startButton.frame.origin.y, 100, 30);
    [stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
}

#pragma mark - Start

- (void)start: (UIButton *)button
{
    [self.roundPicker start];
}

#pragma mark - Stop

- (void)stop: (UIButton *)button
{
    [self.roundPicker stop];
}

@end
