//
//  GameTabview.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameTabview.h"

@implementation GameTabview

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * hitView = [super hitTest:point withEvent:event];
    return self.isUpStatus ? [[[[[hitView superview] superview] superview] superview] superview] : hitView;
}

@end
