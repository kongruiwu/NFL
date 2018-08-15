//
//  TeamerRankHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "TeamerRankHeader.h"

@implementation TeamerRankHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_BackGround;
    self.title = [Factory creatLabelWithText:@""
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.title.backgroundColor = Color_MainBlue;
    
    self.rank = [Factory creatLabelWithText:@"排名"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.teamer = [Factory creatLabelWithText:@"球员"
                                         fontValue:font750(24)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentCenter];
    self.pass = [Factory creatLabelWithText:@"码数"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.arrive = [Factory creatLabelWithText:@"达阵"
                                         fontValue:font750(24)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentCenter];
    self.stop = [Factory creatLabelWithText:@"抄截"
                                       fontValue:font750(24)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.title];
    [self addSubview:self.rank];
    [self addSubview:self.teamer];
    [self addSubview:self.pass];
    [self addSubview:self.arrive];
    [self addSubview:self.stop];
    //40  90 310  90 * 3 40
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.height.equalTo(@(Anno750(60)));
        make.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.width.equalTo(@(Anno750(90)));
        make.top.equalTo(self.title.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    [self.teamer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rank.mas_right);
        make.width.equalTo(@(Anno750(310)));
        make.top.equalTo(self.title.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    [self.pass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamer.mas_right);
        make.width.equalTo(@(Anno750(90)));
        make.top.equalTo(self.title.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    [self.arrive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pass.mas_right);
        make.width.equalTo(@(Anno750(90)));
        make.top.equalTo(self.title.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    [self.stop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrive.mas_right);
        make.right.equalTo(@0);
        make.top.equalTo(self.title.mas_bottom);
        make.bottom.equalTo(@0);
    }];
}

- (void)updateWithTitle:(NSString *)title descs:(NSArray<Stats *> *)descs{
    self.title.text = title;
    self.pass.text = descs[0].sn;
    self.arrive.text = descs[1].sn;
    self.stop.text = descs[2].sn;
}
@end
