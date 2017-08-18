//
//  SubNewsListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubNewsListCell.h"


@implementation SubNewsListCell

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
    self.leftImg = [Factory creatImageViewWithImage:@"list_img_video1"];
    self.nameLabel = [Factory creatLabelWithText:@"詹姆斯-考瑟: 在中国做着很酷的事"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.nameLabel.numberOfLines = 0;
    self.timeLabel = [Factory creatLabelWithText:@"2小时前"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentLeft];
    
    self.likeBtn = [LikeButton buttonWithType:UIButtonTypeCustom];
    
    self.adLabel = [Factory creatLabelWithText:@"推广"
                                     fontValue:font750(22)
                                     textColor:Color_MainBlue
                                 textAlignment:NSTextAlignmentCenter];
    self.adLabel.layer.cornerRadius = Anno750(4);
    self.adLabel.layer.borderColor = Color_MainBlue.CGColor;
    self.adLabel.layer.borderWidth = 0.5f;
    self.adLabel.hidden = YES;
    self.playIcon = [Factory creatImageViewWithImage:@"content_icon_small_play"];
    self.playIcon.hidden = YES;
    [self addSubview:self.leftImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.adLabel];
    [self addSubview:self.likeBtn];
    [self addSubview:self.playIcon];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(284)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(Anno750(24));
        make.top.equalTo(self.leftImg.mas_top).offset(Anno750(20));
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(@(-Anno750(20)));
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.width.equalTo(@(Anno750(60)));
        make.height.equalTo(@(Anno750(26)));
    }];
    [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(10)));
        make.bottom.equalTo(@(-Anno750(10)));
    }];
}

- (void)updateWithObjectModel:(id)model{
    if ([model isKindOfClass:[VideoListModel class]]) {
        [self updateWithVideoListModel:(VideoListModel *)model];
    }else if([model isKindOfClass:[InfoListModel class]]){
        [self updateWithInfoListModel:(InfoListModel *)model];
    }
}
- (void)updateWithVideoListModel:(VideoListModel *)model{
    self.playIcon.hidden = NO;
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
    self.likeBtn.selected = model.collected;
}
- (void)updateWithInfoListModel:(InfoListModel *)model{
    self.playIcon.hidden = YES;
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
    self.likeBtn.selected = model.collected;
}
@end
