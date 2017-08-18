//
//  TeamRightCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamRightCell.h"

@implementation TeamRightCell

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
    self.numlabel = [Factory creatLabelWithText:@"号码"
                                      fontValue:font750(24)
                                      textColor:Color_MainBlack
                                  textAlignment:NSTextAlignmentCenter];
    self.numlabel.backgroundColor = Color_BackGround;
    self.nameLabel = [Factory creatLabelWithText:@"        姓名"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlue
                                   textAlignment:NSTextAlignmentLeft];
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                          fontValue:font750(24)
                                          textColor:Color_MainBlack
                                      textAlignment:NSTextAlignmentCenter];
    self.addressLabel.backgroundColor = UIColorFromRGBA(0x000000, 0.1);
    
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    
    [self addSubview:self.numlabel];
    [self addSubview:self.line1];
    [self addSubview:self.nameLabel];
    [self addSubview:self.line2];
    [self addSubview:self.addressLabel];
    
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(64 * 2)));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numlabel.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@1);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(195 *2)));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.bottom.equalTo(@0);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.left.equalTo(self.line2.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

}
- (void)updateWitPlayerListModel:(PlayerListModel *)model{
    self.numlabel.text = [NSString stringWithFormat:@"%@",model.num];
    self.nameLabel.text = [NSString stringWithFormat:@"        %@",model.name];
    self.addressLabel.text = model.position;
}

@end
