//
//  GameScoreDescCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameScoreDescCell.h"

@implementation GameScoreDescCell

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
    self.lines = [NSMutableArray new];
    self.labels = [NSMutableArray new];
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.topLine = [Factory creatLineView];
    [self addSubview:self.leftImg];
    [self addSubview:self.topLine];
    for (int i = 0; i<6; i++) {
        UILabel * label = [Factory creatLabelWithText:@""
                                            fontValue:font750(24)
                                            textColor:Color_MainBlack
                                        textAlignment:NSTextAlignmentCenter];
        UIView * line = [Factory creatLineView];
        
        [self addSubview:label];
        [self addSubview:line];
        
        [self.labels addObject:label];
        [self.lines addObject:line];
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    float w = (UI_WIDTH - Anno750(122))/self.labels.count;
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    for (int i = 0; i<self.labels.count; i++) {
        UIView * line = self.lines[i];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i * w + Anno750(122)));
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(@0.5);
        }];
        UILabel * label = self.labels[i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right);
            make.width.equalTo(@(w));
            make.centerY.equalTo(@0);
        }];
    }
}
- (void)updateWithTitles:(NSArray *)titles TeamId:(NSNumber *)teamid{
    
    self.leftImg.image = [Factory getImageWithNumer:teamid white:YES];
    
    for (int  i = 0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        label.text = [NSString stringWithFormat:@"%@",titles[i]];
    }
}

@end
