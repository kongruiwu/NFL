//
//  TeamHeadView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamHeadView.h"

@implementation TeamHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{

    self.backgroundColor = Color_MainBlue;
    self.nameLabel = [Factory creatLabelWithText:@"美联北部分区球队"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.lineView = [Factory creatViewWithColor:[UIColor whiteColor]];
    self.subScore = [Factory creatLabelWithText:@"分区\n战绩"
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    self.winProgress = [Factory creatLabelWithText:@"分区\n胜率"
                                         fontValue:font750(24)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.unionScore = [Factory creatLabelWithText:@"联盟\n战绩"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.outScore = [Factory creatLabelWithText:@"外部\n战绩"
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    
    
    self.subScore.numberOfLines = 2;
    self.winProgress.numberOfLines = 2;
    self.unionScore.numberOfLines = 2 ;
    self.outScore.numberOfLines = 2;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.winProgress];
    [self addSubview:self.subScore];
    [self addSubview:self.unionScore];
    [self addSubview:self.outScore];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    float with = UI_WIDTH/8;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
    [self.subScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_left);
        make.width.width.equalTo(@(with));
        make.centerY.equalTo(@0);
    }];
    [self.winProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subScore.mas_right);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(with));
    }];
    [self.unionScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winProgress.mas_right);
        make.width.equalTo(@(with));
        make.centerY.equalTo(@0);
    }];
    [self.outScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(with));
    }];
}


@end
