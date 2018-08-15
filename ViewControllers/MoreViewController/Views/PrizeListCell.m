//
//  PrizeListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizeListCell.h"

@implementation PrizeListCell

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
    self.prizeIcon = [Factory creatImageViewWithImage:@"plac_holderZ"];
    self.prizeIcon.layer.cornerRadius = Anno750(6);
    self.prizeIcon.layer.masksToBounds = YES;
    self.prizeName = [Factory creatLabelWithText:@"NFL球队精品迷你头盔"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.scoreLabel = [Factory creatLabelWithText:@"22000积分"
                                        fontValue:font750(26)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    self.exchangeBtn = [Factory creatButtonWithTitle:@"点击兑换"
                                     backGroundColor:Color_LightBlue
                                           textColor:[UIColor whiteColor]
                                            textSize:font750(26)];
    self.exchangeBtn.layer.cornerRadius = Anno750(8);
    self.exchangeBtn.layer.borderColor = Color_LightBlue.CGColor;
    self.exchangeBtn.layer.borderWidth = 1.0f;
    
    [self.exchangeBtn addTarget:self action:@selector(exchangePrize) forControlEvents:UIControlEventTouchUpInside];
    
    self.line = [Factory creatLineView];
    
    [self addSubview:self.prizeIcon];
    [self addSubview:self.prizeName];
    [self addSubview:self.exchangeBtn];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.line];
    
    [self.prizeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(160)));
        make.height.equalTo(@(Anno750(160)));
    }];
    [self.prizeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prizeIcon.mas_right).offset(Anno750(30));
        make.top.equalTo(self.prizeIcon.mas_top).offset(Anno750(30));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prizeName.mas_left);
        make.top.equalTo(self.prizeName.mas_bottom).offset(Anno750(25));
    }];
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(30)));
        make.width.equalTo(@(Anno750(140)));
        make.height.equalTo(@(Anno750(50)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
}
- (void)updateWithPrizeListModel:(PrizeListModel *)model{
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",model.cost]];
    NSString * score = [NSString stringWithFormat:@"%@",model.cost];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_LightBlue range:NSMakeRange(0, score.length)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:font750(32)] range:NSMakeRange(0, score.length)];
    self.scoreLabel.attributedText = attstr;
    
    [self.prizeIcon sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holderZ"]];
    self.prizeName.text = model.title;
    BOOL rec = [UserManager manager].score.score_season.longLongValue > model.cost.longLongValue;
    if (model.exchanged) {
        self.exchangeBtn.backgroundColor = Color_LightGray;
        [self.exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.exchangeBtn.layer.borderColor = Color_LightGray.CGColor;
        self.exchangeBtn.enabled = NO;
    }else{
        if (rec) {
            self.exchangeBtn.backgroundColor = [UIColor clearColor];
            [self.exchangeBtn setTitleColor:Color_LightBlue forState:UIControlStateNormal];
            self.exchangeBtn.layer.borderColor = Color_LightBlue.CGColor;
            self.exchangeBtn.enabled = YES;
        }else{
            
            [self.exchangeBtn setTitleColor:Color_Line forState:UIControlStateNormal];
            self.exchangeBtn.layer.borderColor = Color_Line.CGColor;
            self.exchangeBtn.enabled = NO;
            self.exchangeBtn.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)exchangePrize{
    
}

@end
