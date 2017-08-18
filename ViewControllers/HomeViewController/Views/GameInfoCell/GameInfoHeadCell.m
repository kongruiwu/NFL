//
//  GameInfoHeadCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameInfoHeadCell.h"

@implementation GameInfoHeadCell

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
    self.nameLabel = [Factory creatLabelWithText:@"直播平台："
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentLeft];
    self.contentLabel = [Factory creatLabelWithText:@""
                                          fontValue:font750(24)
                                          textColor:Color_MainBlack
                                      textAlignment:NSTextAlignmentLeft];
    self.nflLabel = [Factory creatLabelWithText:@"点击进入天天NFL"
                                      fontValue:font750(20)
                                      textColor:Color_MainRed
                                  textAlignment:NSTextAlignmentCenter];
    
    self.nflLabel.hidden = YES;
    self.nflLabel.layer.cornerRadius = Anno750(22);
    self.nflLabel.layer.borderColor = Color_MainRed.CGColor;
    self.nflLabel.layer.borderWidth = 1;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.nflLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(96 *2)));
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.nflLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_left);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(200)));
        make.height.equalTo(@(Anno750(44)));
    }];
}
- (void)updateWithTitle:(NSString *)title content:(NSString *)content{
    self.contentLabel.text = content;
    self.nameLabel.text = title;
    if ([content containsString:@"天天NFL"]) {
        self.contentLabel.text = @"";
        self.nflLabel.hidden = NO;
    }else{
        self.nflLabel.hidden = YES;
    }
    
}
@end
