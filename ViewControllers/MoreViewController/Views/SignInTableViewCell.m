//
//  SignInTableViewCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/19.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SignInTableViewCell.h"

@implementation SignInTableViewCell

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
    self.backgroundColor = [UIColor clearColor];
    
    self.icon = [Factory creatImageViewWithImage:@"score_share"];
    self.nameLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(30)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.missonBtn = [Factory creatButtonWithTitle:@"去完成"
                                   backGroundColor:Color_LightBlue
                                         textColor:[UIColor whiteColor]
                                          textSize:font750(26)];
    self.missonBtn.layer.cornerRadius = Anno750(8);
    self.missonBtn.layer.borderColor = Color_Line.CGColor;
    self.missonBtn.layer.borderWidth = 1.0f;
    [self.missonBtn setTitleColor:Color_LightGray forState:UIControlStateDisabled];
    [self.missonBtn setTitle:@"已完成" forState:UIControlStateDisabled];
    [self.missonBtn addTarget:self action:@selector(missonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.missonBtn];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
    }];
    [self.missonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(50)));
    }];
    
}
- (void)updateWithTitle:(NSString *)title image:(NSString *)imageName{
    self.icon.image = [UIImage imageNamed:imageName];
    self.nameLabel.text = title;
    BOOL rec = NO;
    for (int i = 0; i<[UserManager manager].score.daily.count; i++) {
        if ([[UserManager manager].score.daily[i].title containsString:title]) {
            rec = [UserManager manager].score.daily[i].completed;
        }
    }
    self.missonBtn.backgroundColor = rec ? [UIColor clearColor] : Color_LightBlue;
    self.missonBtn.layer.borderColor = rec ? Color_LightGray.CGColor : Color_LightBlue.CGColor;
    self.missonBtn.enabled = !rec;
}
-(void)missonBtnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(completeTaskClick:)]) {
        [self.delegate completeTaskClick:btn];
    }
}
@end
