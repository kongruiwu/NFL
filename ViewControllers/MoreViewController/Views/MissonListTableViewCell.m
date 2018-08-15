//
//  MissonListTableViewCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/31.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "MissonListTableViewCell.h"

@implementation MissonListTableViewCell

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
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.scoreLabel = [Factory creatLabelWithText:@"+20"
                                        fontValue:font750(30)
                                        textColor:Color_LightBlue
                                    textAlignment:NSTextAlignmentLeft];
    self.overLabel = [Factory creatLabelWithText:@"去完成"
                                       fontValue:font750(26)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.overLabel.backgroundColor = Color_LightBlue;
    self.overLabel.layer.cornerRadius = Anno750(8);
    self.overLabel.layer.borderColor = Color_LightBlue.CGColor;
    self.overLabel.layer.masksToBounds = YES;
    self.overLabel.layer.borderWidth = 0.5f;
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.overLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    [self.overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(50)));
        make.width.equalTo(@(Anno750(120)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.overLabel.mas_left).offset(Anno750(-35));
        make.centerY.equalTo(@0);
    }];
    
}

- (void)updateWithMissonModel:(MissonModel *)model{
    self.nameLabel.text = model.title;
    self.scoreLabel.text = [NSString stringWithFormat:@"+%@",model.exp];
    self.overLabel.layer.borderColor = model.completed ? Color_LightGray.CGColor : Color_LightBlue.CGColor;
    self.overLabel.backgroundColor = model.completed ? [UIColor clearColor] : Color_LightBlue;
    self.overLabel.textColor = model.completed ? Color_LightGray : [UIColor whiteColor];
    self.overLabel.text = model.completed ? @"已完成" : @"去完成";
}
@end
