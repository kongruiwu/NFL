//
//  SubTeamRankCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubTeamRankCell.h"

@implementation SubTeamRankCell

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
    self.leftImg.frame = CGRectMake(Anno750(60), Anno750(10), Anno750(70), Anno750(60));
    self.nameLabel = [self creatlabelWithText:@"印第安纳波利斯小马" Alignment:NSTextAlignmentLeft];
    self.lineView = [Factory creatLineView];
    self.subScore = [self creatlabelWithText:@"4-1" Alignment:NSTextAlignmentCenter];
    self.winProgress = [self creatlabelWithText:@"83.3%" Alignment:NSTextAlignmentCenter];
    self.unionScore = [self creatlabelWithText:@"11-1" Alignment:NSTextAlignmentCenter];
    self.outScore = [self creatlabelWithText:@"3-1" Alignment:NSTextAlignmentCenter];
    self.bottomLine = [Factory creatLineView];
    
    [self addSubview:self.leftImg];
    [self addSubview:self.lineView];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.width.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    float with = UI_WIDTH/8;
    [self.subScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_left);
        make.width.width.equalTo(@(with));
        make.centerY.equalTo(@0);
    }];
    [self.winProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subScore.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(with));
    }];
    [self.unionScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winProgress.mas_right);
        make.width.equalTo(@(with));
        make.centerY.equalTo(@0);
    }];
    [self.outScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(with));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}


- (UILabel *)creatlabelWithText:(NSString *)text Alignment:(NSTextAlignment)align{
    UILabel * label = [Factory creatLabelWithText:text fontValue:font750(24) textColor:Color_DarkGray textAlignment:align];
    [self addSubview:label];
    return label;
}

@end
