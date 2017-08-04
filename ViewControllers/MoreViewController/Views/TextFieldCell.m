//
//  TextFieldCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

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
    self.nameLabel =[Factory creatLabelWithText:@"手机号"
                                      fontValue:font750(28)
                                      textColor:Color_MainBlack
                                  textAlignment:NSTextAlignmentLeft];
    self.textField = [Factory creatTextFiledWithPlaceHold:@""];
    self.line = [Factory creatLineView];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.textField];
    [self addSubview:self.line];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@(Anno750(160)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}
- (void)updateTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
    self.nameLabel.text = title;
    self.textField.placeholder = placeHolder;
}

@end
