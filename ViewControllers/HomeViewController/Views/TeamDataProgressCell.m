//
//  TeamDataProgressCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDataProgressCell.h"

@implementation TeamDataProgressCell

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
    self.leftScore = [Factory creatLabelWithText:@"200"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    self.rightScore = [Factory creatLabelWithText:@"260"
                                        fontValue:font750(28)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentRight];
    self.nameLabel = [Factory creatLabelWithText:@"传球码数"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentRight];
    self.slider = [[UISlider alloc]init];
    self.slider.maximumValue = 100;
    self.slider.minimumValue = 0;
    self.slider.value = 50;
    self.slider.minimumTrackTintColor = Color_MainRed;
    self.slider.maximumTrackTintColor = Color_MainBlue;
    [self.slider setThumbImage:[UIImage imageNamed:@"progresscenter"] forState:UIControlStateNormal];
    
    [self addSubview:self.leftScore];
    [self addSubview:self.rightScore];
    [self addSubview:self.nameLabel];
    [self addSubview:self.slider];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(20)));
    }];
    [self.leftScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.bottom.equalTo(self.slider.mas_top).offset(Anno750(-5));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftScore.mas_centerY);
        make.centerX.equalTo(@0);
    }];
    [self.rightScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.leftScore.mas_centerY);
    }];
}

- (void)updateWithTitles:(NSString *)title leftScore:(NSNumber *)left rightScore:(NSNumber *)right isTime:(BOOL)rec{
    self.nameLabel.text = title;
    int leftv = [left intValue];
    int rightv = [right intValue];
    int value ;
    if (leftv+rightv == 0) {
        value = 0;
    }else{
        value = (leftv * 100) / (leftv + rightv);
    }
    
    
    self.slider.value = value;
    self.leftScore.text = [NSString stringWithFormat:@"%@",left];
    self.rightScore.text = [NSString stringWithFormat:@"%@",right];
    if (rec) {
        self.leftScore.text = [Factory getTimeStingWithCurrentTime:leftv andTotalTime:leftv];
        self.rightScore.text = [Factory getTimeStingWithCurrentTime:rightv andTotalTime:rightv];
    }
    
}

- (void)updateThirdWithTitles:(NSString *)title leftScore:(NSNumber *)left rightScore:(NSNumber *)right{
    self.nameLabel.text = title;
    self.leftScore.text = [NSString stringWithFormat:@"%.2f%%",[left floatValue]];
    self.rightScore.text = [NSString stringWithFormat:@"%.2f%%",[right floatValue]];
    int leftv = [left intValue];
    int rightv = [right intValue];
    int value ;
    if (leftv+rightv == 0) {
        value = 0;
    }else{
        value = (leftv * 100) / (leftv + rightv);
    }
    self.slider.value = value;
}

@end
