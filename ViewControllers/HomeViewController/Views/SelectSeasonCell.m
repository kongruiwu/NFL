//
//  SelectSeasonCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/4/2.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SelectSeasonCell.h"

@implementation SelectSeasonCell

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
    self.nameLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.selectImg = [Factory creatImageViewWithImage:@"list_icon_right_normal"];
    self.lineView = [Factory creatLineView];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.selectImg];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
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
- (void)updateWithSeason:(NSInteger)season isSelect:(BOOL)rec{
    self.nameLabel.text = [NSString stringWithFormat:@"%ld赛季",(long)season];
    self.nameLabel.textColor = rec ? [UIColor whiteColor] : Color_MainBlack;
    self.selectImg.hidden = !rec;
    self.backgroundColor = rec ? Color_MainBlue : [UIColor whiteColor];
}
@end
