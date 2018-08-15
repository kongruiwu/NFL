//
//  ScoreRankBotomCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/1.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "ScoreRankBotomCell.h"

@implementation ScoreRankBotomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.numLabel = [Factory creatLabelWithText:@"NO.4"
                                      fontValue:font750(28)
                                      textColor:Color_LightGray
                                  textAlignment:NSTextAlignmentLeft];
    self.nameLabel = [Factory creatLabelWithText:@"油焖大虾"
                                       fontValue:font750(28)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.scoreLabel = [Factory creatLabelWithText:@"25000积分"
                                        fontValue:font750(28)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    //50 74
    self.levelIcon = [Factory creatImageViewWithImage:@"jiangzhang"];
    self.levelLabel = [Factory creatLabelWithText:@"等级 Lv2"
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    self.line = [Factory creatLineView];
    [self addSubview:self.numLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.levelLabel];
    [self addSubview:self.levelIcon];
    [self addSubview:self.line];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(32)));
        make.centerY.equalTo(@0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(120)));
        make.centerY.equalTo(@0);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(270)));
        make.centerY.equalTo(@0);
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(630)));
        make.centerY.equalTo(@0);
    }];
    [self.levelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.levelLabel.mas_left).offset(Anno750(-10));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(25)));
        make.height.equalTo(@(Anno750(37)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}
- (void)updateWithScoreRankModel:(ScoreListModel *)model{
    self.nameLabel.text = model.username;
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",model.score]];
    [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font750(26)] range:NSMakeRange(0, attstr.length - 3)];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_LightBlue range:NSMakeRange(0, attstr.length - 3)];
    self.scoreLabel.attributedText = attstr;
    self.levelLabel.text = [NSString stringWithFormat:@"等级 Lv%@",model.lv];
    self.numLabel.text = [NSString stringWithFormat:@"NO.%@",model.rank];
}

@end
