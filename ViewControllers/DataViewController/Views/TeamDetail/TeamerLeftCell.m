//
//  TeamerLeftCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerLeftCell.h"

@implementation TeamerLeftCell

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
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                          fontValue:font750(24)
                                          textColor:Color_MainBlack
                                      textAlignment:NSTextAlignmentCenter];
    self.addressLabel.backgroundColor = Color_BackGround;
    self.fristLabel = [Factory creatLabelWithText:@"    首发"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlue
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel = [Factory creatLabelWithText:@"    替补"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel.backgroundColor = UIColorFromRGBA(0x000000, 0.1);
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.line1];
    [self addSubview:self.fristLabel];
    [self addSubview:self.line2];
    [self addSubview:self.otherLabel];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(64 * 2)));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@1);
    }];
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(180)));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fristLabel.mas_right);
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.bottom.equalTo(@0);
    }];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.left.equalTo(self.line2.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}


@end
