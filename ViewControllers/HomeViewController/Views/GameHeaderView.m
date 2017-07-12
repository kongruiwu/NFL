//
//  GameHeaderView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameHeaderView.h"

@implementation GameHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{

    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_big"];
//    [self.groundImg setContentMode:UIViewContentModeScaleAspectFill];
//    [self.groundImg setClipsToBounds:YES];
    self.groundImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    self.blueImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.blueImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.blueImg.alpha = 0;
    
    [self addSubview:self.groundImg];
    [self addSubview:self.blueImg];
}
@end
