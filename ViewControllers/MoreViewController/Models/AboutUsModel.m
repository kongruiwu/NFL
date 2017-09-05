//
//  AboutUsModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/23.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AboutUsModel.h"

@implementation AboutInfoModel


@end

@implementation AboutUsModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.weixin_gz = [[AboutInfoModel alloc]initWithDictionary:dic[@"weixin_gz"]];
        self.weibo = [[AboutInfoModel alloc]initWithDictionary:dic[@"weibo"]];
        self.home_site = [[AboutInfoModel alloc]initWithDictionary:dic[@"home_site"]];
        self.email = [[AboutInfoModel alloc]initWithDictionary:dic[@"email"]];
    }
    return self;
}

@end
