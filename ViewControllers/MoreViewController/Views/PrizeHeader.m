//
//  PrizeHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizeHeader.h"

@implementation PrizeHeader
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backImg = [Factory creatImageViewWithImage:@"nav_bg_hig130_default"];
    [self.backImg setContentMode:UIViewContentModeScaleAspectFill];
    [self.backImg setClipsToBounds:YES];
    
    self.scoreLabel = [Factory creatLabelWithText:@""
                                        fontValue:font750(62)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:font750(80)];
    self.descLabel = [Factory creatLabelWithText:@"当前积分"
                                       fontValue:font750(26)
                                       textColor:[UIColor colorWithRed:0.51 green:0.64 blue:0.76 alpha:1.00]
                                   textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.backImg];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.descLabel];
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@(-Anno750(60)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(self.descLabel.mas_top).offset(-Anno750(24));
    }];
}
- (void)updateScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",[UserManager manager].score.score_season];
}

@end
