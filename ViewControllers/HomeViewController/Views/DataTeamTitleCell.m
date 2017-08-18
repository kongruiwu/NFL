//
//  DataTeamTitleCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "DataTeamTitleCell.h"

@implementation DataTeamTitleCell

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
    self.labels = [NSMutableArray new];
    self.nameLabel = [Factory creatLabelWithText:@"塞巴斯蒂安·雅尼考斯基"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlue
                                   textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.nameLabel];
    for (int i = 0; i<4; i++) {
        UILabel * label = [Factory creatLabelWithText:@""
                                            fontValue:font750(24)
                                            textColor:Color_MainBlue
                                        textAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        [self.labels addObject:label];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    float w = (UI_WIDTH - Anno750(304))/4;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.width.equalTo(@(Anno750(280)));
        make.centerY.equalTo(@0);
    }];
    for (int i = 0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(i * w);
            make.centerY.equalTo(@0);
            make.width.equalTo(@(w));
        }];
    }
}
- (void)updateWithtitles:(NSArray *)titles{
    BOOL rec = YES;
    for (id obj in titles) {
        if (![obj isKindOfClass:[NSString class]]) {
            rec = NO;
            break;
        }
    }
    self.backgroundColor = rec ? Color_MainBlue : [UIColor whiteColor];
    self.nameLabel.textColor = rec ? [UIColor whiteColor] : Color_MainBlue;
    for (int i = 0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        label.textColor = rec ? [UIColor whiteColor] : Color_DarkGray;
        label.text = [NSString stringWithFormat:@"%@",titles[i+1]];
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@",titles[0]];
}

@end
