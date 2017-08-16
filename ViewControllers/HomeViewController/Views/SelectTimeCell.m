//
//  SelectTimeCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SelectTimeCell.h"

@implementation SelectTimeCell

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
    self.nameLabel = [Factory creatLabelWithText:@"第一周"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.descLabel = [Factory creatLabelWithText:@"09.20 - 09.26"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentLeft];
    self.selectImg = [Factory creatImageViewWithImage:@"list_icon_right_normal"];
    self.lineView = [Factory creatLineView];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.selectImg];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(20)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(5));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(Anno750(-24)));
    }];
}
- (void)updateWithTimeListModel:(TimeListModel *)model{
    self.nameLabel.text = model.title;
    self.descLabel.text = model.date_str;
    self.descLabel.textColor = model.isSelect ? [UIColor whiteColor] : Color_LightGray;
    self.nameLabel.textColor = model.isSelect ? [UIColor whiteColor] : Color_MainBlack;
    self.selectImg.hidden = !model.isSelect;
    self.backgroundColor = model.isSelect ? Color_MainBlue : [UIColor whiteColor];
}
@end
