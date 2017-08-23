//
//  NullView.m
//  KeTing
//
//  Created by 吴孔锐 on 2017/7/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NullView.h"

@implementation NullView

- (instancetype)initWithFrame:(CGRect)frame andNullType:(NullType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.nullType = type;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_BackGround;
    self.clearBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.imgView = [Factory creatImageViewWithImage:@""];
    self.descLabel = [Factory creatLabelWithText:@""
                                         fontValue:font750(28)
                                         textColor:Color_LightGray
                                     textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.imgView];
    [self addSubview:self.descLabel];
    [self addSubview:self.clearBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(170)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgView.mas_bottom).offset(Anno750(30));
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}
- (void)setNullType:(NullType)nullType{
    _nullType = nullType;
    NSString * imageName;
    NSString * desc;
    switch (self.nullType) {
        case NullTypeNetError:
            imageName = @"empty_page3";
            desc = @"网络有问题，点我重新加载";
            break;
        case NullTypeNoneLike:
            imageName = @"empty_page7";
            desc = @"至今还没赞过呢，你好挑剔啊";
            break;
        case NullTypeNoneData:
            imageName = @"empty_page4";
            desc = @"暂无数据，敬请期待";
            break;
        case NullTypeNoneCollect:
            imageName = @"empty_page2";
            desc = @"暂无收藏，快去收藏吧！";
            break;
        default:
            break;
    }
    self.imgView.image = [UIImage imageNamed:imageName];
    self.descLabel.text = desc;
}

@end
