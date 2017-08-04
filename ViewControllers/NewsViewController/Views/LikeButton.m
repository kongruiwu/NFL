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
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, (contentRect.size.height - Anno750(22))/2, Anno750(60), Anno750(26));
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(Anno750(60-24), Anno750(2), Anno750(24), Anno750(24));
}


@end
