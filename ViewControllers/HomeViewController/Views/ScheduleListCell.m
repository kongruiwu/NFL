//
//  ScheduleListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScheduleListCell.h"

@implementation ScheduleListCell

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
    self.timeLabel = [Factory creatLabelWithText:@"vs"
                                       fontValue:font750(30)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.videoButton = [Factory creatButtonWithTitle:@"  精彩视频"
                                     backGroundColor:[UIColor clearColor]
                                           textColor:Color_MainBlue
                                            textSize:font750(22)];
    [self.videoButton setImage:[UIImage imageNamed:@"list_icon_video_default"] forState:UIControlStateNormal];
    
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.leftScore = [Factory creatLabelWithText:@"23"
                                       fontValue:font750(52)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.leftName = [Factory creatLabelWithText:@"圣路易斯公羊"
                                      fontValue:font750(24)
                                      textColor:Color_DarkGray
                                  textAlignment:NSTextAlignmentCenter];
    self.statusLabel = [Factory creatLabelWithText:@"已结束"
                                         fontValue:font750(22)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.statusLabel.layer.cornerRadius = Anno750(20);
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.backgroundColor = Color_TagGray;
    self.rightScore = [Factory creatLabelWithText:@"17"
                                        fontValue:font750(52)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.rightName = [Factory creatLabelWithText:@"西雅图海鹰"
                                       fontValue:font750(24)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentCenter];
    self.line = [Factory creatLineView];
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.videoButton];
    [self.contentView addSubview:self.leftName];
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.leftScore];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.rightScore];
    [self.contentView addSubview:self.rightImg];
    [self.contentView addSubview:self.rightName];
    [self.contentView addSubview:self.line];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(20)));
        make.height.equalTo(@(Anno750(30)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@(Anno750(-24)));
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(40)));
    }];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-Anno750(750 / 2 - 120)));
        make.centerY.equalTo(@(-Anno750(220/2 - 80)));

    }];
    [self.leftScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(Anno750(60));
        make.centerY.equalTo(@0);
    }];
    [self.leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftImg.mas_centerX);
        make.top.equalTo(self.leftImg.mas_bottom).offset(Anno750(6));
    }];
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(Anno750(750 / 2 - 120)));
        make.centerY.equalTo(@(-Anno750(220/2 - 80)));
    }];
    [self.rightScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(Anno750(-60));
        make.centerY.equalTo(@0);
    }];
    [self.rightName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightImg.mas_centerX);
        make.top.equalTo(self.rightImg.mas_bottom).offset(Anno750(6));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    
}
@end
