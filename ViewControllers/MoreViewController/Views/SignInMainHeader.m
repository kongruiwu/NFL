//
//  SignInMainHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/30.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SignInMainHeader.h"

#define lightGray   [UIColor colorWithRed:0.51 green:0.64 blue:0.76 alpha:1.00]

@implementation SignInMainHeader
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.bgImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
//    [self.bgImg setContentMode:UIViewContentModeScaleAspectFill];
    [self.bgImg setClipsToBounds:YES];
    
    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.cornerRadius = Anno750(110/2);
    self.userIcon.layer.borderColor = Color_MainBlue.CGColor;
    self.userIcon.layer.borderWidth = 2.0f;
    
    self.nameLabel = [Factory creatLabelWithText:@"汤姆布雷迪"
                                       fontValue:font750(32)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.levelLabel = [Factory creatLabelWithText:@"等级 Lv2"
                                        fontValue:font750(24)
                                        textColor:lightGray
                                    textAlignment:NSTextAlignmentLeft];
    self.levelIcon = [Factory creatImageViewWithImage:@"jiangzhang"];
    
    self.prizeBg = [Factory creatImageViewWithImage:@"porfile_bg_edit_default"];
    self.prizeIcon = [Factory creatImageViewWithImage:@"prize"];
    self.prizeName = [Factory creatLabelWithText:@"兑换奖品"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.nextIcon = [Factory creatImageViewWithImage:@"gengduo"];
    self.prizeBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    
    self.scoreLabel = [Factory creatLabelWithText:@"209"
                                        fontValue:font750(36)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:font750(50)];
    self.scoreName = [Factory creatLabelWithText:@"当前积分"
                                       fontValue:font750(26)
                                       textColor:lightGray
                                   textAlignment:NSTextAlignmentCenter];
    
    self.dayCount = [Factory creatLabelWithText:@"197天"
                                      fontValue:font750(26)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    self.dayName = [Factory creatLabelWithText:@"当前已连续签到"
                                     fontValue:font750(26)
                                     textColor:lightGray
                                 textAlignment:NSTextAlignmentCenter];
    
    self.rankNum = [Factory creatLabelWithText:@"32"
                                     fontValue:font750(36)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentCenter];
    self.rankNum.font = [UIFont boldSystemFontOfSize:font750(50)];
    self.rankName = [Factory creatLabelWithText:@"积分排行"
                                      fontValue:font750(26)
                                      textColor:lightGray
                                  textAlignment:NSTextAlignmentCenter];
    
    self.rankBtn = [Factory creatButtonWithTitle:@"积分排行榜"
                                 backGroundColor:[UIColor clearColor]
                                       textColor:Color_LightBlue
                                        textSize:font750(30)];
    self.rankBtn.layer.cornerRadius = Anno750(30);
    self.rankBtn.layer.borderWidth = 1.0f;
    self.rankBtn.layer.borderColor = Color_LightBlue.CGColor;
    
    self.missonNum = [Factory creatLabelWithText:@"任务数  1/5"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentRight];
    
    self.todayMisson = [Factory creatButtonWithTitle:@"今日任务"
                                     backGroundColor:[UIColor whiteColor]
                                           textColor:Color_LightBlue
                                            textSize:font750(36)];
    self.playerMisson = [Factory creatButtonWithTitle:@"新手任务"
                                      backGroundColor:[UIColor whiteColor]
                                            textColor:Color_LightBlue
                                             textSize:font750(36)];
    self.todayMisson.layer.cornerRadius = Anno750(10);
    self.playerMisson.layer.cornerRadius = Anno750(10);
    self.playerMisson.titleLabel.font = [UIFont boldSystemFontOfSize:font750(36)];
    self.todayMisson.titleLabel.font = [UIFont boldSystemFontOfSize:font750(36)];
    
    [self addSubview:self.bgImg];
    [self addSubview:self.userIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.levelLabel];
    [self addSubview:self.levelIcon];
    [self addSubview:self.prizeBg];
    [self.prizeBg addSubview:self.prizeIcon];
    [self.prizeBg addSubview:self.prizeName];
    [self.prizeBg addSubview:self.nextIcon];
    [self addSubview:self.prizeBtn];
    
    [self addSubview:self.scoreName];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.dayName];
    [self addSubview:self.dayCount];
    [self addSubview:self.rankBtn];
    [self addSubview:self.rankNum];
    [self addSubview:self.rankName];
    
    [self addSubview:self.missonNum];
    [self addSubview:self.todayMisson];
    [self addSubview:self.playerMisson];
    
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.top.equalTo(@(Anno750(15)));
        make.height.equalTo(@(Anno750(110)));
        make.width.equalTo(@(Anno750(110)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(Anno750(34));
        make.bottom.equalTo(self.userIcon.mas_centerY).offset(Anno750(-6));
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.userIcon.mas_centerY).offset(Anno750(6));
    }];
    [self.levelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(30));
        make.centerY.equalTo(self.userIcon.mas_centerY);
    }];
    
    [self.prizeBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(self.userIcon.mas_centerY);
    }];
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-30)));
        make.centerY.equalTo(@(-Anno750(8)));
        make.height.equalTo(@(Anno750(18)));
        make.width.equalTo(@(Anno750(20)));
    }];
    [self.prizeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.centerY.equalTo(@(-Anno750(8)));
        make.height.equalTo(@(Anno750(32)));
        make.width.equalTo(@(Anno750(32)));
    }];
    [self.prizeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@(-Anno750(8)));
        make.left.equalTo(self.prizeIcon.mas_right);
        make.right.equalTo(self.nextIcon.mas_left);
    }];
    [self.prizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prizeBg.mas_left);
        make.right.equalTo(@0);
        make.top.equalTo(self.prizeBg.mas_top);
        make.bottom.equalTo(self.prizeBg.mas_bottom);
    }];
    [self.dayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).offset(Anno750(100));
        make.centerX.equalTo(@0);
        make.width.equalTo(@(Anno750(220)));
    }];
    [self.dayCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dayName.mas_top).offset(-Anno750(14));
        make.centerX.equalTo(@0);
        make.width.equalTo(@(Anno750(220)));
    }];
    [self.scoreName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.right.equalTo(self.dayName.mas_left);
        make.centerY.equalTo(self.dayName.mas_centerY);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreName.mas_left);
        make.right.equalTo(self.scoreName.mas_right);
        make.centerY.equalTo(self.dayCount.mas_centerY);
    }];
    [self.rankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayName.mas_right);
        make.right.equalTo(@(-Anno750(30)));
        make.centerY.equalTo(self.dayName.mas_centerY);
    }];
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankName.mas_left);
        make.right.equalTo(self.rankName.mas_right);
        make.centerY.equalTo(self.dayCount.mas_centerY);
    }];
    
    [self.rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayName.mas_bottom).offset(Anno750(34));
        make.centerX.equalTo(@0);
        make.width.equalTo(@(Anno750(220)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.missonNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.bottom.equalTo(@(-Anno750(130)));
    }];
    
    [self.todayMisson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.bottom.equalTo(@(Anno750(-20)));
        make.width.equalTo(@(Anno750(250)));
        make.height.equalTo(@(Anno750(70)));
    }];
    [self.playerMisson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(44)));
        make.bottom.equalTo(@(Anno750(-20)));
        make.width.equalTo(@(Anno750(250)));
        make.height.equalTo(@(Anno750(70)));
    }];
    
}

- (void)updateWithScoreRankModel:(ScoreRankModel *)model isDaily:(BOOL)rec{
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].info.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    self.nameLabel.text = [UserManager manager].info.username;
    self.levelLabel.text = [NSString stringWithFormat:@"等级 Lv%@",model.lv];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",model.score_available];
    self.rankNum.text = [NSString stringWithFormat:@"%@",model.rank];
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@天",model.sign_continu_days]];
    [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font750(50)] range:NSMakeRange(0, attstr.length - 1)];
    self.dayCount.attributedText = attstr;
    if (rec) {
        self.missonNum.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.dailyOverCount,(long)model.daily.count];
    }else{
        self.missonNum.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.newbieOverCount,(long)model.newbie.count];
    }
}

@end
