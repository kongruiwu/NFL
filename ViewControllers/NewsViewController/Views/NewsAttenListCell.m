//
//  NewsAttenListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewsAttenListCell.h"

@implementation NewsAttenListCell

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
    self.topImg = [Factory creatImageViewWithImage:@"list_img_video2"];
    self.nameLabel = [Factory creatLabelWithText:@"爱国者13-21德州人"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.timeLabel = [Factory creatLabelWithText:@"06月13日  12:25"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentLeft];
    self.likeBtn = [LikeButton buttonWithType:UIButtonTypeCustom];
    self.likeBtn.selected = YES;
    self.playIcon = [Factory creatImageViewWithImage:@"content_icon_big_play"];
    
    self.playIcon.hidden = YES;
    
    [self addSubview:self.topImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.likeBtn];
    [self.topImg addSubview:self.playIcon];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(420)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.topImg.mas_bottom).offset(Anno750(24));
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(20));
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.height.equalTo(@(Anno750(80)));
    }];
    [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
}


- (void)updateWithObjectModel:(id)model{
    if ([model isKindOfClass:[VideoListModel class]]) {
        [self updateWithVideoListModel:(VideoListModel *)model];
    }else if([model isKindOfClass:[InfoListModel class]]){
        [self updateWithInfoListModel:(InfoListModel *)model];
    }
}
- (void)updateWithInfoListModel:(InfoListModel *)model{
    self.playIcon.hidden = YES;
    [self.topImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
}
- (void)updateWithVideoListModel:(VideoListModel *)model{
    self.playIcon.hidden = NO;
    [self.topImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
}

@end
