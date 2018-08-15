//
//  PrizeHeaderCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizeHeaderCell.h"

@implementation PrizeHeaderCell

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
    
    self.backgroundColor = Color_BackGround;
    
    self.bgImg = [Factory creatImageViewWithImage:@"prizeBg"];
    self.prizeIcon = [Factory creatImageViewWithImage:@"plac_holderZ"];
    self.prizeIcon.layer.cornerRadius = Anno750(6);
    self.prizeIcon.layer.masksToBounds = YES;
    self.prizeName = [Factory creatLabelWithText:@"NFL球队精品迷你头盔"
                                       fontValue:font750(28)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.scoreLabel = [Factory creatLabelWithText:@"25000 积分"
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.bgImg];
    [self.bgImg addSubview:self.prizeIcon];
    [self.bgImg addSubview:self.prizeName];
    [self.bgImg addSubview:self.scoreLabel];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(18)));
        make.right.equalTo(@(-Anno750(18)));
        make.top.equalTo(@(Anno750(16)));
        make.height.equalTo(@(Anno750(228)));
    }];
    [self.prizeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(160)));
        make.width.equalTo(@(Anno750(160)));
    }];
    [self.prizeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prizeIcon.mas_right).offset(Anno750(26));
        make.top.equalTo(self.prizeIcon.mas_top).offset(Anno750(20));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prizeName.mas_left);
        make.bottom.equalTo(self.prizeIcon.mas_bottom).offset(Anno750(-50));
    }];
}

- (void)updateWithPrizeListModel:(PrizeListModel *)model{
    NSString * score = [NSString stringWithFormat:@"%@",model.cost];
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",score]];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_LightBlue range:NSMakeRange(0, score.length)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font750(32)] range:NSMakeRange(0, score.length)];
    self.scoreLabel.attributedText = attstr;
    
    [self.prizeIcon sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holderZ"]];
    self.prizeName.text = model.title;
    
}

@end
