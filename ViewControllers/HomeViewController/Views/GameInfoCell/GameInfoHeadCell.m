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
    self.contentLabel.numberOfLines = 0;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
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
}
- (void)updateWithTitle:(NSString *)title content:(NSString *)content{
    if ([content containsString:@"天天NFL"]) {
        self.contentLabel.text = @"    点击进入天天NFL    ";
        self.contentLabel.layer.borderColor = Color_MainRed.CGColor;
        self.contentLabel.layer.borderWidth = 1.0f;
        self.contentLabel.layer.cornerRadius = Anno750(22);
        self.contentLabel.textColor = Color_MainRed;
    }else{
        self.contentLabel.textColor = Color_MainBlack;
        self.contentLabel.layer.borderWidth = 0;
        self.contentLabel.text = content;
    }
    self.nameLabel.text = title;
}
@end
