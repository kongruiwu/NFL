//
//  LikeButton.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LikeButton.h"

@implementation LikeButton


+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    LikeButton * button = [super buttonWithType:buttonType];
    if (button) {
        [button creatUI];
    }
    return button;
}
- (void)creatUI{
    [self setImage:[UIImage imageNamed:@"list_icon_collection_nor"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"list_icon_collection_hig"] forState:UIControlStateSelected];
    [self setTitle:@"63" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:font750(22)];
    [self setTitleColor:Color_LightGray forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(24)));
        make.height.equalTo(@(Anno750(24)));
    }];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageView.mas_left).offset(Anno750(-12));
        make.bottom.equalTo(self.imageView.mas_bottom).offset(Anno750(5));
        make.height.equalTo(@(Anno750(26)));
        make.width.equalTo(@(Anno750(50)));
    }];
    
}


@end
