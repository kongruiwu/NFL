//
//  UserInfoSettingCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserInfoSettingCell.h"

@implementation UserInfoSettingCell

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

    self.nameLabel = [Factory creatLabelWithText:@"头像"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.hidden = YES;
    self.userIcon.layer.cornerRadius = Anno750(50);
    self.userIcon.layer.masksToBounds = YES;
    self.descLabel = [Factory creatLabelWithText:@"设置"
                                       fontValue:font750(26)
                                       textColor:Color_MainBlue
                                   textAlignment:NSTextAlignmentRight];
    self.nextIcon = [Factory creatArrowImage];
    self.lineView = [Factory creatLineView];
    
    self.wechat = [Factory creatImageViewWithImage:@""];
    self.qq = [Factory creatImageViewWithImage:@""];
    self.weibo = [Factory creatImageViewWithImage:@""];
    
    self.wechat.hidden = YES;
    self.qq.hidden = YES;
    self.weibo.hidden = YES;
    
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.userIcon];
    [self addSubview:self.descLabel];
    [self addSubview:self.nextIcon];
    [self addSubview:self.lineView];
    [self addSubview:self.weibo];
    [self addSubview:self.wechat];
    [self addSubview:self.qq];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-24)));
        make.centerY.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(self.nextIcon.mas_left).offset(Anno750(-30));
    }];
    if (!self.userIcon.hidden) {
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.nextIcon.mas_left).offset(Anno750(-30));
            make.centerY.equalTo(@0);
            make.height.equalTo(@(Anno750(100)));
            make.width.equalTo(@(Anno750(100)));
        }];
    }
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextIcon.mas_left).offset(Anno750(-30));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(52)));
        make.width.equalTo(@(Anno750(52)));
    }];
    [self.qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.weibo.mas_left).offset(Anno750(-20));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(52)));
        make.width.equalTo(@(Anno750(52)));
    }];
    [self.wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.qq.mas_left).offset(Anno750(-20));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(52)));
        make.width.equalTo(@(Anno750(52)));
    }];
    
}
- (void)updateUserIconWithTitle:(NSString *)title{
    self.descLabel.hidden = YES;
    self.userIcon.hidden = NO;
    self.nameLabel.text = title;
    if ([UserManager manager].hasPic) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].info.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    }
    
}
- (void)updateWithTitle:(NSString *)title desc:(NSString *)desc hidden:(BOOL)rec{
    self.nameLabel.text = title;
    self.descLabel.text = desc;
    self.nextIcon.hidden = rec;
    self.descLabel.textColor = [desc isEqualToString:@"设置"] ? Color_MainBlue : Color_LightGray;
    
}
- (void)updateThirdLogIcon{
    self.weibo.hidden = NO;
    self.qq.hidden = NO;
    self.wechat.hidden = NO;
    self.weibo.image = [UIImage imageNamed:@"list_login_icon_weibo"];
    self.qq.image = [UIImage imageNamed:@"list_icon_qq"];
    self.wechat.image = [UIImage imageNamed:@"list_login_icon_wechat"];
}
@end
