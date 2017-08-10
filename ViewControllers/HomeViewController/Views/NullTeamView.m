//
//  NullTeamView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NullTeamView.h"

@implementation NullTeamView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.iconImg = [Factory creatImageViewWithImage:@"content_img_nothing"];
    self.descLabel = [Factory creatLabelWithText:@"关注你喜欢的球队\n第一时间获取比赛资讯"
                                       fontValue:font750(26)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentCenter];
    self.descLabel.numberOfLines = 2;
    self.chooseBtn = [Factory creatButtonWithTitle:@"+ 关注球队"
                                   backGroundColor:[UIColor clearColor]
                                         textColor:Color_MainBlue
                                          textSize:font750(30)];
    self.chooseBtn.layer.borderColor = Color_MainBlue.CGColor;
    self.chooseBtn.layer.borderWidth = 1.0f;
    self.chooseBtn.layer.cornerRadius= 4.0f;
    
    [self addSubview:self.iconImg];
    [self addSubview:self.descLabel];
    [self addSubview:self.chooseBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Anno750(260)));
        make.centerX.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.iconImg.mas_bottom).offset(Anno750(30));
    }];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.descLabel.mas_bottom).offset(Anno750(40));
        make.width.equalTo(@(Anno750(200)));
        make.height.equalTo(@(Anno750(60)));
    }];
}

@end
