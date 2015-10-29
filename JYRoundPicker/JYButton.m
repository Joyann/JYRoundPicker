//
//  JYButton.m
//  JYRoundPicker
//
//  Created by joyann on 15/10/27.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYButton.h"

@implementation JYButton

- (void)setHighlighted:(BOOL)highlighted
{
    // 取消高亮
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat btnW = 40;
    CGFloat btnH = 50;
    CGFloat btnX = (contentRect.size.width - btnW) * 0.5;
    CGFloat btnY = 25;
    
    return CGRectMake(btnX, btnY, btnW, btnH);
}

// 设置可点击区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 50);
    if (CGRectContainsPoint(rect, point)) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}



@end
