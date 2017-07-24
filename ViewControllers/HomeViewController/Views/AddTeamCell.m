//
//  AddTeamCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AddTeamCell.h"

@implementation AddTeamCell

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
    self.teamOne = [[TeamImageView alloc]init];
    self.teamTwo = [[TeamImageView alloc]init];
    self.teamThree = [[TeamImageView alloc]init];
    self.teamFour = [[TeamImageView alloc]init];
    
    [self addSubview:self.teamOne];
    [self addSubview:self.teamTwo];
    [self addSubview:self.teamThree];
    [self addSubview:self.teamFour];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.teamOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(10)));
        make.top.equalTo(@(Anno750(20)));
        make.width.equalTo(@(Anno750(170)));
        make.height.equalTo(@(Anno750(190)));
    }];
    [self.teamFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(10)));
        make.centerY.equalTo(self.teamOne.mas_centerY);
        make.width.equalTo(self.teamOne.mas_width);
        make.height.equalTo(self.teamOne.mas_height);
    }];
    float with = Anno750((730 - 4 * 170)/3);
    [self.teamTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamOne.mas_right).offset(with);
        make.centerY.equalTo(self.teamOne.mas_centerY);
        make.width.equalTo(self.teamOne.mas_width);
        make.height.equalTo(self.teamOne.mas_height);
    }];
    [self.teamThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.teamFour.mas_left).offset(-with);
        make.centerY.equalTo(self.teamOne.mas_centerY);
        make.width.equalTo(self.teamOne.mas_width);
        make.height.equalTo(self.teamOne.mas_height);
    }];
}


@end
