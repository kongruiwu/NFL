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
    self.titleLabel.font = [UIFont systemFontOfSize:font750(24)];
    [self setTitleColor:Color_LightGray forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.frame.size.width - Anno750(24),(self.frame.size.height - Anno750(24))/2, Anno750(24), Anno750(24));
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    CGSize size = [Factory getSize:self.titleLabel.text maxSize:CGSizeMake(9999, 9999) font:self.titleLabel.font];
    self.titleLabel.frame = CGRectMake(self.frame.size.width - Anno750(35) - size.width, (self.frame.size.height - size.height)/2, size.width+2, size.height);
    
}


@end
