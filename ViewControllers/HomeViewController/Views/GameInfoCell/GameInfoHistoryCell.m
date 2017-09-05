//
//  GameInfoHistoryCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameInfoHistoryCell.h"

@implementation GameInfoHistoryCell

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
    self.leftImg = [Factory creatImageViewWithImage:@""];
    self.rightImg = [Factory creatImageViewWithImage:@""];
    self.leftScore = [Factory creatLabelWithText:@""
                                       fontValue:font750(52)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.rightScore = [Factory creatLabelWithText:@""
                                        fontValue:font750(52)
                                        textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter];
    self.timeLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(20)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.timeLabel.numberOfLines = 2;
    
    self.lineView = [Factory creatLineView];
    
    [self addSubview:self.leftImg];
    [self addSubview:self.leftScore];
    [self addSubview:self.rightImg];
    [self addSubview:self.rightScore];
    [self addSubview:self.timeLabel];
    [self addSubview:self.lineView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(Anno750(32)));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@(Anno750(120)));
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(Anno750(-32)));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@(Anno750(120)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.leftScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(Anno750(80));
        make.centerY.equalTo(@0);
    }];
    [self.rightScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(-Anno750(80));
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateWithLiveViewModel:(VsLogModel *)model{
    self.leftImg.image = [Factory getImageWithNumer:model.visitor_teamId white:YES];
    self.rightImg.image =[Factory getImageWithNumer:model.home_teamId white:YES] ;
    self.leftScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
    self.rightScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
    
    self.leftScore.textColor = model.home_scores.intValue >= model.visitor_scores.intValue ? Color_LightGray : Color_MainBlack;
    self.rightScore.textColor = model.home_scores.intValue <= model.visitor_scores.intValue ? Color_LightGray : Color_MainBlack;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY年\nMM月dd日"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.time.integerValue];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    self.timeLabel.text = confromTimespStr;
}

@end
