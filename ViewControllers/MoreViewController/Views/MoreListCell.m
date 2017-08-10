//
//  MoreListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MoreListCell.h"

@implementation MoreListCell

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
    self.leftImg = [Factory creatImageViewWithImage:@""];
    self.nameLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(30)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.descLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentRight];
    self.nextIcon = [Factory creatArrowImage];
    self.bottomLine = [Factory creatLineView];
    self.redIcon = [Factory creatViewWithColor:[UIColor redColor]];
    self.redIcon.layer.cornerRadius = Anno750(5);
    self.redIcon.hidden = YES;
    [self addSubview:self.leftImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.nextIcon];
    [self addSubview:self.bottomLine];
    [self addSubview:self.redIcon];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.leftImg.mas_right).offset(Anno750(30));
    }];
    [self.redIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(10));
        make.top.equalTo(self.nameLabel.mas_top).offset(Anno750(5));
        make.width.equalTo(@(Anno750(10)));
        make.height.equalTo(@(Anno750(10)));
    }];
    
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextIcon.mas_left).offset(-Anno750(24));
        make.centerY.equalTo(@0);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}
- (void)updateWithTitle:(NSString *)title image:(NSString *)iamge desc:(NSString *)desc{
    self.nameLabel.text = title;
    self.leftImg.image = [UIImage imageNamed:iamge];
    self.descLabel.text = desc;
}
@end
