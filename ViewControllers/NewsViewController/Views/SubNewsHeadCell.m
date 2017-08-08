//
//  SubNewsHeadCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubNewsHeadCell.h"

@implementation SubNewsHeadCell

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
    self.bgImg = [Factory creatImageViewWithImage:@"list_img_Journalism1"];
    self.bgView = [Factory creatViewWithColor:UIColorFromRGBA(0x000000, 0.7)];
    self.nameLabel = [Factory creatLabelWithText:@"德马留斯-托马斯感觉自己重返青春"
                                       fontValue:font750(28)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.bgImg];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(80)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(Anno750(-24)));
        make.centerY.equalTo(self.bgView.mas_centerY);
    }];
}
- (void)updateWithModel:(InfoCoverModel *)model{
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.nameLabel.text = model.title;
}
@end
