//
//  TeamImageView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamImageView.h"

@implementation TeamImageView

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.userInteractionEnabled = YES;
    
    self.teamImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.selectImg = [Factory creatImageViewWithImage:@"list_button_60x60_sel"];
    self.teamImg.userInteractionEnabled = YES;
    self.selectImg.userInteractionEnabled = YES;
    self.nameLabel = [Factory creatLabelWithText:@"亚特兰大猎鹰"
                                       fontValue:font750(24)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentCenter];
    self.nameLabel.numberOfLines = 2;
    self.clearBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    [self addSubview:self.selectImg];
    [self addSubview:self.nameLabel];
    [self.selectImg addSubview:self.teamImg];
    [self addSubview:self.clearBtn];
    self.selected = NO;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [self.teamImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(14)));
        make.right.equalTo(@(-Anno750(14)));
        make.top.equalTo(self.selectImg.mas_bottom).offset(Anno750(10));
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}
- (void)updateWithTeamModel:(TeamModel *)model{
    self.nameLabel.text = model.name;
}
@end
