//
//  GameScoreTitleCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameScoreTitleCell.h"

@implementation GameScoreTitleCell

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
    NSArray * arr =@[@"1",@"2",@"3",@"4",@"总分"];
    self.labels = [NSMutableArray new];
    for (int i = 0; i<arr.count; i++) {
        UILabel * label = [Factory creatLabelWithText:arr[i]
                                            fontValue:font750(24)
                                            textColor:Color_LightGray
                                        textAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        [self.labels addObject:label];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    float w = (UI_WIDTH - Anno750(122))/self.labels.count;
    for (int i =0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i * w + Anno750(122)));
            make.width.equalTo(@(w));
            make.centerY.equalTo(@0);
        }];
    }
}
@end
