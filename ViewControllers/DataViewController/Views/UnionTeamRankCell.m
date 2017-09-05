//
//  UnionTeamRankCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UnionTeamRankCell.h"

@implementation UnionTeamRankCell

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
    self.rankNum = [self creatlabelWithText:@"1." Alignment:NSTextAlignmentLeft];
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.leftImg.frame = CGRectMake(Anno750(60), Anno750(10), Anno750(70), Anno750(70));
    self.nameLabel = [self creatlabelWithText:@"印第安纳波利斯小马" Alignment:NSTextAlignmentLeft];
    self.centerLine = [Factory creatLineView];
    self.bottomLine = [Factory creatLineView];
    self.winLabel = [self creatlabelWithText:@"4" Alignment:NSTextAlignmentCenter];
    self.loseLabel = [self creatlabelWithText:@"0" Alignment:NSTextAlignmentCenter];
    self.drawLabel = [self creatlabelWithText:@"0" Alignment:NSTextAlignmentCenter];
    self.winProLabel = [self creatlabelWithText:@"100%" Alignment:NSTextAlignmentCenter];
    self.winScore = [self creatlabelWithText:@"34" Alignment:NSTextAlignmentCenter];
    
    [self addSubview:self.leftImg];
    [self addSubview:self.centerLine];
    [self addSubview:self.bottomLine];
}

- (UILabel *)creatlabelWithText:(NSString *)text Alignment:(NSTextAlignment)align{
    UILabel * label = [Factory creatLabelWithText:text fontValue:font750(24) textColor:Color_DarkGray textAlignment:align];
    [self addSubview:label];
    return label;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.width.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(135)));
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(20)));
    }];
    [self.winLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerLine.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
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
//- (void)updateImageSize{
//    UIImage * image = [UIImage imageNamed:@"list_logo_60x60_aiguozhe"];
//    CGSize size = image.size;
//    
//}
- (void)updateWithTeamRankModel:(TeamRankModel *)model{
    self.rankNum.text = [NSString stringWithFormat:@"%@",model.idx];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.winLabel.text = [NSString stringWithFormat:@"%@",model.win];
    self.loseLabel.text = [NSString stringWithFormat:@"%@",model.lose];
    self.drawLabel.text = [NSString stringWithFormat:@"%@",model.tie];
    self.winProLabel.text = model.win_pct;
    self.winScore.text = [NSString stringWithFormat:@"%@",model.net_points];
    self.leftImg.image = [Factory getImageWithNumer:model.team_id white:YES];
}
@end
