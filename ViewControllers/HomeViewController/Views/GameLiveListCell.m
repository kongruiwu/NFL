//
//  GameLiveListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameLiveListCell.h"

@implementation GameLiveListCell

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

    self.leftLine = [Factory creatLineView];
    self.sectionLabel = [Factory creatLabelWithText:@"第四节"
                                          fontValue:font750(20)
                                          textColor:Color_LightGray
                                      textAlignment:NSTextAlignmentCenter];
    self.timeLabel = [Factory creatLabelWithText:@"14 : 45"
                                       fontValue:font750(20)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentCenter];
    self.nameLabel = [Factory creatLabelWithText:@"1档10码 爱国者阵前20码"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:font750(24)];
    
    self.descLabel = [Factory creatLabelWithText:@"T.Brady左路长传，被E.Berry抄截，E.Berry回攻16码，被J.White擒抱"
                                       fontValue:font750(24)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 0;
    
    self.crycleView = [Factory creatViewWithColor:Color_MainBlue];
    self.crycleView.layer.cornerRadius = Anno750(8);
    
    [self addSubview:self.leftLine];
    [self addSubview:self.sectionLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.crycleView];

}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.width.equalTo(@0.5);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.leftLine.mas_left);
        make.top.equalTo(@(Anno750(2)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.leftLine.mas_left);
        make.top.equalTo(self.sectionLabel.mas_bottom).offset(Anno750(5));
    }];
    [self.crycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftLine.mas_centerX);
        make.top.equalTo(@(Anno750(10)));
        make.height.equalTo(@(Anno750(16)));
        make.width.equalTo(@(Anno750(16)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLine.mas_right).offset(Anno750(48));
        make.top.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(8));
        make.right.equalTo(@(-Anno750(24)));
    }];
}

- (void)updateWithLiveDetailModel:(LiveDetailModel *)model{
    self.sectionLabel.text = model.quarter;
    self.timeLabel.text = model.time;
    self.descLabel.text = model.content;
    NSString * title ;
    if (model.down_yards && [model.down_yards isKindOfClass:[NSString class]] && model.down_yards.length > 0) {
        title = [NSString stringWithFormat:@"%@  %@",model.down_yards,model.yardline];
    }else{
        title = model.yardline;
    }
    self.nameLabel.text = title;;
    
}

@end
