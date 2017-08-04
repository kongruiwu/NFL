//
//  SettingTableViewCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

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
    self.nameLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.switchView = [[UISwitch alloc]init];
    self.switchView.onTintColor = Color_MainBlue;
    self.descLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(26)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentRight];
    self.nextIcon = [Factory creatArrowImage];
    self.line = [Factory creatLineView];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.switchView];
    [self addSubview:self.nextIcon];
    [self addSubview:self.descLabel];
    [self addSubview:self.line];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextIcon.mas_left).offset(-Anno750(12));
        make.centerY.equalTo(@0);
    }];
}

- (void)updateWithTitle:(NSString *)title desc:(NSString *)desc switch:(BOOL)rec{
    self.nameLabel.text = title;
    self.descLabel.text = desc;
    self.switchView.hidden = rec;
    self.nextIcon.hidden = !rec;
}

@end
