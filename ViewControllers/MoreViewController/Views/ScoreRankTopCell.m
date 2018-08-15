//
//  ScoreRankTopCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/31.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "ScoreRankTopCell.h"

@implementation ScoreRankTopCell

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
    self.numberLabel = [Factory creatLabelWithText:@"NO.1"
                                         fontValue:font750(36)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.numberLabel.backgroundColor = Color_MainBlue;
    
    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.cornerRadius = Anno750(110/2);
    self.userIcon.layer.borderColor = Color_MainBlue.CGColor;
    self.userIcon.layer.borderWidth = 2.0f;
    
    self.nameLabel = [Factory creatLabelWithText:@"汤姆布雷迪"
                                       fontValue:font750(32)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.scoreLabel = [Factory creatLabelWithText:@"25000积分"
                                        fontValue:font750(28)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    self.levelIcon = [Factory creatImageViewWithImage:@"jiangzhang"];
    self.levelLabel = [Factory creatLabelWithText:@"等级  Lv2"
                                        fontValue:font750(26)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    self.line = [Factory creatLineView];
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.userIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.levelLabel];
    [self addSubview:self.levelIcon];
    [self addSubview:self.line];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(Anno750(140)));
    }];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(Anno750(24));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(110)));
        make.height.equalTo(@(Anno750(110)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(Anno750(-5));
        make.left.equalTo(self.userIcon.mas_right).offset(Anno750(24));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.mas_centerY).offset(Anno750(5));
    }];
    
    [self.levelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_top);
        make.right.equalTo(@(-Anno750(50)));
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.levelIcon.mas_centerX);
        make.bottom.equalTo(self.userIcon.mas_bottom);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (void)updateWithScoreRankModel:(ScoreListModel *)model indexRow:(NSInteger)indexrow{
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    self.nameLabel.text = model.username;
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",model.score]];
    [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font750(26)] range:NSMakeRange(0, attstr.length - 3)];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_LightBlue range:NSMakeRange(0, attstr.length - 3)];
    self.scoreLabel.attributedText = attstr;
    self.levelLabel.text = [NSString stringWithFormat:@"等级 Lv%@",model.lv];
    self.numberLabel.text = [NSString stringWithFormat:@"NO.%@",model.rank];
    UIColor * color;
    switch (indexrow + 1) {
        case 1:
            color = [UIColor colorWithRed:0.04 green:0.25 blue:0.46 alpha:1.00];
            break;
        case 2:
            color = [UIColor colorWithRed:0.22 green:0.40 blue:0.56 alpha:1.00];
            break;
        case 3:
            color = [UIColor colorWithRed:0.41 green:0.55 blue:0.67 alpha:1.00];
            break;
        case 4:
            color = [UIColor colorWithRed:0.60 green:0.69 blue:0.78 alpha:1.00];
            break;
        default:
            color = [UIColor clearColor];
            break;
    }
    self.numberLabel.backgroundColor = color;
}
@end
