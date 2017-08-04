//
//  AttentionTeamHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AttentionTeamHeader.h"

@implementation AttentionTeamHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.addBtn = [Factory creatButtonWithNormalImage:@"nav_button_add_normal" selectImage:nil];    
    
    [self addSubview:self.groundImg];
    [self addSubview:self.addBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.groundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(80)));
    }];
    
    
}
- (void)updateWithTeams:(NSArray *)arr{
    for (int i = 0; i<arr.count; i++) {
        
    }
}

@end
