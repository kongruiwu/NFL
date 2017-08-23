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
    self.tagImgs = [NSMutableArray new];
    
    self.timeLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(52)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.videoButton = [Factory creatButtonWithTitle:@"  精彩视频"
                                     backGroundColor:[UIColor clearColor]
                                           textColor:Color_MainBlue
                                            textSize:font750(22)];
    [self.videoButton setImage:[UIImage imageNamed:@"list_icon_video_default"] forState:UIControlStateNormal];
    [self.videoButton addTarget:self action:@selector(videoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.videoButton.hidden = YES;
    
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.leftScore = [Factory creatLabelWithText:@""
                                       fontValue:font750(52)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.leftName = [Factory creatLabelWithText:@""
                                      fontValue:font750(24)
                                      textColor:Color_DarkGray
                                  textAlignment:NSTextAlignmentCenter];
    self.statusLabel = [Factory creatLabelWithText:@""
                                         fontValue:font750(20)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.statusLabel.layer.cornerRadius = Anno750(20);
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.backgroundColor = Color_TagGray;
    self.rightScore = [Factory creatLabelWithText:@""
                                        fontValue:font750(52)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    self.vsLabel = [Factory creatLabelWithText:@"VS"
                                     fontValue:font750(24)
                                     textColor:Color_DarkGray
                                 textAlignment:NSTextAlignmentCenter];
    self.vsLabel.hidden = YES;
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.rightName = [Factory creatLabelWithText:@""
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
    [self.contentView addSubview:self.vsLabel];
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
        make.centerY.equalTo(@(-Anno750(20)));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@(Anno750(-40)));
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(40)));
    }];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.top.equalTo(@(Anno750(20)));
        make.width.equalTo(@(Anno750(120)));
        make.height.equalTo(@(Anno750(120)));
    }];
    [self.leftScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(Anno750(60));
        make.centerY.equalTo(@0);
    }];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.leftScore.mas_centerY);
    }];
    [self.leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftImg.mas_centerX);
        make.top.equalTo(self.leftImg.mas_bottom).offset(Anno750(6));
    }];
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(60)));
        make.top.equalTo(@(Anno750(20)));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@(Anno750(120)));
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
        make.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}
- (void)updateWithMatchDetailModel:(MatchDetailModel *)model{
    if (self.tagImgs.count > 0 ) {
        for (UIImageView * img in self.tagImgs) {
            [img removeFromSuperview];
        }
        [self.tagImgs removeAllObjects];
    }
    self.leftName.text = model.home_name;
    self.rightName.text = model.visitor_name;
    self.leftImg.image = [Factory getImageWithNumer:model.home_teamId white:YES];
    self.rightImg.image = [Factory getImageWithNumer:model.visitor_teamId white:YES];
    switch ([model.match_state intValue]) {
        case 0://未开始
        {
            self.statusLabel.backgroundColor = Color_TagBlue;
            self.statusLabel.text = @"比赛前瞻";
            self.leftScore.text = @"";
            self.rightScore.text = @"";
            self.timeLabel.text = [Factory timestampSwitchWithHourStyleTime:[model.time integerValue]];
            self.videoButton.hidden = YES;
            self.vsLabel.hidden = YES;
            
            for (int i = 0; i<model.relay_list.count; i++) {
                UIImageView * img = [Factory creatImageViewWithImage:@""];
                [img sd_setImageWithURL:[NSURL URLWithString:model.relay_list[i].logo]];
                [self.contentView addSubview:img];
                img.tag = i;
                if (model.relay_list.count%2 == 0) {
                    if (i%2 == 0) {
                        if (i == 0) {
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.right.equalTo(self.mas_centerX);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }else{
                            UIImageView * rightImg = [self viewWithTag: i - 2];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.right.equalTo(rightImg.mas_right);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }
                        
                    }else if(i%2 == 1){
                        if (i == 1) {
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(self.mas_centerX);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }else{
                            UIImageView * leftImg = [self viewWithTag: i - 2];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(leftImg.mas_right);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }
                        
                    }
                }else{
                    if (i == 0) {
                        [img mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(@0);
                            make.top.equalTo(@(Anno750(20)));
                            make.width.equalTo(@(Anno750(100)));
                            make.height.equalTo(@(Anno750(40)));
                        }];
                    }else if(i%2 == 0){
                        if (i == 2) {
                            UIImageView * centerImg = [self viewWithTag: 0];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.right.equalTo(centerImg.mas_left);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }else{
                            UIImageView * rightImg = [self viewWithTag: i - 2];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.right.equalTo(rightImg.mas_right);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }
                    }else {
                        if (i == 1) {
                            UIImageView * centerImg = [self viewWithTag: 0];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(centerImg.mas_right);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }else{
                            UIImageView * leftImg = [self viewWithTag: i - 2];
                            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(leftImg.mas_right);
                                make.top.equalTo(@(Anno750(20)));
                                make.width.equalTo(@(Anno750(100)));
                                make.height.equalTo(@(Anno750(40)));
                            }];
                        }
                        
                    }
                    
                }
                [self.tagImgs addObject:img];
            }
        }
            break;
        case 1://正在进行
        {
            self.statusLabel.backgroundColor = Color_MainRed;
            self.statusLabel.text = @"进行中";
            self.leftScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
            self.rightScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
            self.timeLabel.text = @"";
            self.videoButton.hidden = YES;
            self.vsLabel.hidden = NO;
            
        }
            break;
        case 2://已结束
        {
            self.statusLabel.backgroundColor = Color_TagGray;
            self.statusLabel.text = @"已结束";
            self.leftScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
            self.rightScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
            self.timeLabel.text = @"";
            self.videoButton.hidden = model.video.length> 0 ? NO : YES;
            self.vsLabel.hidden = NO;
            
        }
            break;
        default:
            break;
    }
    
}
- (void)videoButtonClick:(UIButton *)btn{
    if ([self.delgate respondsToSelector:@selector(checkOverMatchVideo:)]) {
        [self.delgate checkOverMatchVideo:btn];
    }

}

@end
