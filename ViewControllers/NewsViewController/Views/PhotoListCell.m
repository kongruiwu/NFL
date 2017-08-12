//
//  PhotoListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoListCell.h"

@implementation PhotoListCell

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
    self.bgImg = [Factory creatImageViewWithImage:@"list_img_Journalism2"];
    self.grayView = [Factory creatViewWithColor:UIColorFromRGBA(0x000000, 0.3)];
    self.topLine = [Factory creatViewWithColor:UIColorFromRGBA(0xFFFFFF, 0.5)];
    self.bottomLine = [Factory creatViewWithColor:UIColorFromRGBA(0xFFFFFF, 0.5)];
    self.titleLabel = [Factory creatLabelWithText:@"球星图集"
                                        fontValue:font750(40)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:font750(40)];
    
    [self addSubview:self.bgImg];
    [self addSubview:self.grayView];
    [self addSubview:self.topLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(Anno750(-20));
        make.height.equalTo(@(Anno750(4)));
        make.width.equalTo(self.titleLabel.mas_width);
        make.centerX.equalTo(@0);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(20));
        make.height.equalTo(@(Anno750(4)));
        make.width.equalTo(self.titleLabel.mas_width);
        make.centerX.equalTo(@0);
    }];
}
- (void)updateWithPhotoSetModel:(PhotoSetModel *)model{
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holder"]];
    self.titleLabel.text = model.title;
    
}
@end
