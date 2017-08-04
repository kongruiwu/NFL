//
//  TeamUnionHeadView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamUnionHeadView.h"

@implementation TeamUnionHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_MainBlue;
    self.nameLabel = [Factory creatLabelWithText:@"美联球队"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.lineView = [Factory creatViewWithColor:[UIColor whiteColor]];
    self.winLabel = [Factory creatLabelWithText:@"胜"
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    self.loseLabel = [Factory creatLabelWithText:@"负"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.drawLabel = [Factory creatLabelWithText:@"平"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.winProLabel = [Factory creatLabelWithText:@"胜率"
                                         fontValue:font750(24)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.winScore = [Factory creatLabelWithText:@"净胜分"
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.winScore];
    [self addSubview:self.winLabel];
    [self addSubview:self.drawLabel];
    [self addSubview:self.winProLabel];
    [self addSubview:self.loseLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
    }];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(Anno750(20));
        make.width.equalTo(@(Anno750(50)));
        make.centerY.equalTo(@0);
    }];
    [self.loseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
    }];
    [self.drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loseLabel.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
    }];
    [self.winProLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.drawLabel.mas_right);
        make.width.equalTo(@(Anno750(80)));
        make.centerY.equalTo(@0);
    }];
    [self.winScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winProLabel.mas_right);
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
}

@end
