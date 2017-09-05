//
//  NewUserTeachView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewUserTeachView.h"

@implementation NewUserTeachView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.page = 1;
    NSString * title = [NSString stringWithFormat:@"新手引导-%d.jpg",self.page];
    self.bgImg = [Factory creatImageViewWithImage:title];
    self.nextBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    [self.nextBtn addTarget:self action:@selector(showNextImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.bgImg];
    [self addSubview:self.nextBtn];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(Anno750(200)));
        make.width.equalTo(@(Anno750(200)));
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(700)));
    }];
}
- (void)showNextImage{
    self.page++;
    if (self.page>3) {
        [self removeFromSuperview];
        return;
    }
    NSString * title = [NSString stringWithFormat:@"新手引导-%d.jpg",self.page];
    self.bgImg.image = [UIImage imageNamed:title];
}

@end
