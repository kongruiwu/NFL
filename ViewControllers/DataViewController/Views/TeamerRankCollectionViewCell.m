//
//  TeamerRankCollectionViewCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerRankCollectionViewCell.h"

@implementation TeamerRankCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.rankNum = [Factory creatLabelWithText:@"1"
                                     fontValue:font750(24)
                                     textColor:Color_MainBlack
                                 textAlignment:NSTextAlignmentLeft];
    self.teamerImg = [Factory creatImageViewWithImage:@"porfile_photo_default1"];
    self.teamerImg.layer.cornerRadius = Anno750(60);
    self.teamerImg.layer.masksToBounds = YES;
    self.nameLabel = [Factory creatLabelWithText:@"格斯特考斯基"
                                       fontValue:font750(26)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.teamLabel = [Factory creatLabelWithText:@"新英格兰爱国者"
                                       fontValue:font750(22)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.rankNum];
    [self addSubview:self.teamerImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.teamLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Anno750(20)));
        make.left.equalTo(@(Anno750(14)));
    }];
    [self.teamerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(20)));
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(120)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.teamerImg.mas_centerX);
        make.top.equalTo(self.teamerImg.mas_bottom).offset(Anno750(5));
    }];
    [self.teamLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.teamerImg.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(5));
    }];
}
- (void)updateWithRankPlayer:(RankPlayer *)player{
    self.rankNum.text = [NSString stringWithFormat:@"%@",player.idx];
    [self.teamerImg sd_setImageWithURL:[NSURL URLWithString:player.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    self.nameLabel.text = player.name;
    self.teamLabel.text = player.team_name;
}


@end
