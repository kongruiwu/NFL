//
//  NullView.h
//  KeTing
//
//  Created by 吴孔锐 on 2017/7/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
typedef NS_ENUM(NSInteger,NullType){
    NullTypeNetError = 0,   //网络不给力
    NullTypeNoneLike    ,   //暂无点赞
    NullTypeNoneData  ,   //暂无数据
    NullTypeNoneCollect,    //暂无收藏
};

@interface NullView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, assign) NullType nullType;
@property (nonatomic, strong) UIButton * clearBtn;

- (instancetype)initWithFrame:(CGRect)frame andNullType:(NullType)type;
@end
