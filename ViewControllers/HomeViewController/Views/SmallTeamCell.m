//
//  SmallTeamCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SmallTeamCell.h"

@implementation SmallTeamCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    self.selectImg = [Factory creatImageViewWithImage:@"list_button_60x60_sel"];
    self.teamImg = [Factory creatImageViewWithImage:@""];
    
    [self addSubview:self.selectImg];
    [self addSubview:self.teamImg];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(80)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [self.teamImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(80)));
        make.height.equalTo(@(Anno750(80)));
    }];
    self.backgroundColor = [UIColor clearColor];
}

@end
