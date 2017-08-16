//
//  TeamDetailHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDetailHeader.h"

@implementation TeamDetailHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.bgImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    
    self.teamImg = [Factory creatImageViewWithImage:@""];
    self.teamImg.layer.borderColor = Color_TagBlue.CGColor;
    self.teamImg.layer.borderWidth = 0.5f;
    self.teamImg.layer.cornerRadius = Anno750(60);
    
    self.name_zn = [Factory creatLabelWithText:@"猎鹰"
                                     fontValue:font750(32)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentLeft];
    
    self.name_en = [Factory creatLabelWithText:@"Atlanta Falcons"
                                     fontValue:font750(24)
                                     textColor:Color_White_3
                                 textAlignment:NSTextAlignmentLeft];
    self.teamVideo = [Factory creatButtonWithTitle:@"观看球队介绍视频"
                                   backGroundColor:Color_TagBlue
                                         textColor:[UIColor whiteColor]
                                          textSize:font750(18)];
    self.teamVideo.layer.cornerRadius = Anno750(18);
    
    self.scoreLabel = [Factory creatLabelWithText:@"12胜4负"
                                        fontValue:font750(20)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentRight];
    self.belongLabel = [Factory creatLabelWithText:@"所属：国家联合会 南部分区"
                                         fontValue:font750(24)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentLeft];
    self.creatAt = [Factory creatLabelWithText:@"创立时间：1966-01-01"
                                     fontValue:font750(24)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentLeft];
    self.playground = [Factory creatLabelWithText:@"球场：Georgia Dome"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentLeft];
    self.address = [Factory creatLabelWithText:@"地点：Atlanta"
                                     fontValue:font750(24)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentLeft];
    self.line = [Factory creatLineView];
    self.selectView = [[SelectTopView alloc]initWithFrame:CGRectMake(0, Anno750(148 * 2), UI_WIDTH, Anno750(80)) andTitles:@[@"数据",@"赛程",@"球员",@"资讯"]];

    [self addSubview:self.bgImg];
    [self addSubview:self.teamImg];
    [self addSubview:self.name_en];
    [self addSubview:self.name_zn];
    [self addSubview:self.teamVideo];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.line];
    [self addSubview:self.belongLabel];
    [self addSubview:self.playground];
    [self addSubview:self.creatAt];
    [self addSubview:self.address];
    [self addSubview:self.selectView];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.teamImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(32)));
        make.top.equalTo(@(Anno750(12)));
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(120)));
    }];
    [self.name_zn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teamImg.mas_top);
        make.left.equalTo(self.teamImg.mas_right).offset(Anno750(28));
    }];
    [self.name_en mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name_zn.mas_bottom).offset(Anno750(5));
        make.left.equalTo(self.name_zn.mas_left);
    }];
    [self.teamVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_zn.mas_left);
        make.top.equalTo(self.name_en.mas_bottom).offset(Anno750(8));
        make.width.equalTo(@(Anno750(180)));
        make.height.equalTo(@(Anno750(36)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-30)));
        make.centerY.equalTo(self.teamImg.mas_centerY);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teamImg.mas_bottom).offset(Anno750(50));
        make.height.equalTo(@(Anno750(68)));
        make.width.equalTo(@0.5);
        make.centerX.equalTo(@0);
    }];
    [self.belongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.right.equalTo(self.line.mas_left).offset(-Anno750(24));
        make.top.equalTo(self.line.mas_top);
    }];
    [self.playground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line.mas_bottom);
        make.left.equalTo(self.belongLabel.mas_left);
        make.right.equalTo(self.belongLabel.mas_right);
    }];
    [self.creatAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_right).offset(Anno750(40));
        make.top.equalTo(self.line.mas_top);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.creatAt.mas_left);
        make.bottom.equalTo(self.line.mas_bottom);
        make.right.equalTo(self.creatAt.mas_right);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}


@end
