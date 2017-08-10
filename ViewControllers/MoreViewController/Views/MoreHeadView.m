//
//  MoreHeadView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MoreHeadView.h"

@implementation MoreHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    self.clearButton = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    
    self.bgImage = [Factory creatImageViewWithImage:@"nav_bg_hig130_default"];
    [self.bgImage setContentMode:UIViewContentModeScaleAspectFill];
    [self.bgImage setClipsToBounds:YES];
    
    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.layer.cornerRadius = Anno750(50);
    self.userIcon.layer.borderColor = Color_MainBlue.CGColor;
    self.userIcon.layer.borderWidth = 1.0f;
    self.loginLabel = [Factory creatLabelWithText:@"点击登录"
                                       fontValue:font750(32)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.nameLabel = [Factory creatLabelWithText:@"汤姆布雷迪"
                                       fontValue:font750(30)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.descLabel = [Factory creatLabelWithText:@"城市 · 性别"
                                       fontValue:font750(24)
                                       textColor:UIColorFromRGBA(0xFFFFFF, 0.5)
                                   textAlignment:NSTextAlignmentLeft];
    self.editImage = [Factory creatImageViewWithImage:@"porfile_bg_edit_default"];
    self.editLabel = [Factory creatLabelWithText:@"编辑资料 >"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentRight];
    self.teamIcon = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    
    [self addSubview:self.bgImage];
    [self addSubview:self.userIcon];
    [self addSubview:self.loginLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.editImage];
    [self addSubview:self.clearButton];
    [self.editImage addSubview:self.teamIcon];
    [self.editImage addSubview:self.editLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(36)));
        make.width.equalTo(@(Anno750(100)));
        make.height.equalTo(@(Anno750(100)));
        make.bottom.equalTo(@(-Anno750(54)));
    }];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(Anno750(40));
        make.centerY.equalTo(self.userIcon);
    }];
    [self.editImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(self.userIcon.mas_centerY);
    }];
    [self.editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@(-Anno750(8)));
    }];
    [self.teamIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(16)));
        make.centerY.equalTo(@(-Anno750(8)));
        make.height.equalTo(@(Anno750(70)));
        make.width.equalTo(@(Anno750(70)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editImage.mas_top);
        make.left.equalTo(self.loginLabel.mas_left);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.editImage.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

- (void)updateUIbyUserInfo{
    self.loginLabel.hidden = [UserManager manager].isLogin;
    self.nameLabel.text = [UserManager manager].isLogin ? [UserManager manager].info.username : @"";
    self.descLabel.text = [UserManager manager].isLogin ? @"城市 · 性别" : @"";
    self.editImage.hidden = ![UserManager manager].isLogin;
    if ([UserManager manager].isLogin) {
        [self.editImage setImage:[UIImage imageNamed:@""]];
    }
}


@end
