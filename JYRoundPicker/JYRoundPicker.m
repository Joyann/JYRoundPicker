//
//  JYRoundPicker.m
//  JYRoundPicker
//
//  Created by joyann on 15/10/27.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYRoundPicker.h"
#import "JYButton.h"

@interface JYRoundPicker ()

@property (weak, nonatomic) IBOutlet UIImageView *roundWheel;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, weak) JYButton *preButton;

@end

@implementation JYRoundPicker

#pragma mark - Getter Methods

- (CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}

#pragma mark - Initializer Methods

+ (instancetype)roundPicker
{
    JYRoundPicker *roundPicker = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYRoundPicker class]) owner:nil options:nil] firstObject];
    return roundPicker;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYRoundPicker class]) owner:nil options:nil] firstObject];
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

#pragma mark - Set Up

- (void)setUp
{
    self.roundWheel.userInteractionEnabled = YES;
    
    CGFloat buttonWidth = 68.0;
    CGFloat buttonHeight = 143.0;
    CGPoint roundPickerCenter = CGPointMake(self.roundWheel.bounds.size.width * 0.5, self.roundWheel.bounds.size.height * 0.5);
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *luckyAstrologyImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selLuckyAstrologyImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = luckyAstrologyImage.size.width / 12.0 * scale;
    CGFloat imageH = luckyAstrologyImage.size.height * scale;
    
    // 创建12个按钮
    for (int i = 0; i < 12; i++) {
        CGFloat angleDelta = M_PI * 2 / 12;
        JYButton *button = [JYButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        button.layer.anchorPoint = CGPointMake(0.5, 1.0);
        button.layer.position = CGPointMake(roundPickerCenter.x, roundPickerCenter.y);
        button.transform = CGAffineTransformMakeRotation(angleDelta * i);
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(handleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        imageX = i * imageW;
        CGImageRef normalImage = CGImageCreateWithImageInRect(luckyAstrologyImage.CGImage, CGRectMake(imageX, imageY, imageW, imageH));
        CGImageRef selImage = CGImageCreateWithImageInRect(selLuckyAstrologyImage.CGImage, CGRectMake(imageX, imageY, imageW, imageH));
        [button setImage:[UIImage imageWithCGImage:normalImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithCGImage:selImage] forState:UIControlStateSelected];
        [self.roundWheel addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            self.preButton = button;
        }
    }
}

#pragma mark - Handle Button Click

- (void)handleBtnClick: (JYButton *)button
{
    self.preButton.selected = NO;
    button.selected = YES;
    self.preButton = button;
}

#pragma mark - Actions

- (void)start
{
    self.link.paused = NO;
}

- (void)stop
{
    self.link.paused = YES;
}

#pragma mark - Handle Display Link

- (void)handleDisplayLink: (CADisplayLink *)link
{
    self.roundWheel.transform = CGAffineTransformRotate(self.roundWheel.transform, M_PI / 200.0);
}

#pragma mark - Choose Number

- (IBAction)chooseNumber:(id)sender
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 6);
    rotationAnimation.duration = 1.5;
    rotationAnimation.delegate = self;
    [self.roundWheel.layer addAnimation:rotationAnimation forKey:nil];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        CGAffineTransform transform = self.preButton.transform;
        CGFloat angle = atan2f(transform.b, transform.a);
        self.roundWheel.transform = CGAffineTransformMakeRotation(-angle);
    }
}


@end
