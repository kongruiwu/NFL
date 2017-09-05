//
//  EnterTeachView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "EnterTeachView.h"

@implementation EnterTeachView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = UIColorFromRGBA(0x000000, 0.7);
    self.enterBtn = [Factory creatButtonWithTitle:@"新手教学入口 →"
                                  backGroundColor:[UIColor clearColor]
                                        textColor:[UIColor whiteColor]
                                         textSize:font750(24)];
    self.closeBtn = [Factory creatButtonWithNormalImage:@"banner_icon_close_normal" selectImage:nil];
    
    [self addSubview:self.enterBtn];
    [self addSubview:self.closeBtn];
    
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.width.equalTo(@(Anno750(100)));
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

@end
