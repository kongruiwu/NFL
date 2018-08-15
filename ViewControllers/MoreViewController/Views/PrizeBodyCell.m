//
//  PrizeBodyCell.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizeBodyCell.h"

@implementation PrizeBodyCell

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
    self.nameLabel= [Factory creatLabelWithText:@"兑换时间:"
                                      fontValue:font750(28)
                                      textColor:Color_DarkGray
                                  textAlignment:NSTextAlignmentLeft];
    self.valueTextf = [Factory creatTextFiledWithPlaceHold:@""];
    self.line = [Factory creatLineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.valueTextf];
    [self addSubview:self.line];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    [self.valueTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(224)));
        make.right.equalTo(@(-Anno750(30)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

- (void)updateWithTitle:(NSString *)title placeHold:(NSString *)placeHold{
    self.nameLabel.text = title;
    self.valueTextf.placeholder = placeHold;
    if ([title containsString:@"时间"]) {
        self.valueTextf.text = [self timestampSwitchWithHourStyleTime:time(NULL)];
        self.valueTextf.enabled = NO;
    }else{
        self.valueTextf.enabled = YES;
    }
}
-(NSString *)timestampSwitchWithHourStyleTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}
@end
