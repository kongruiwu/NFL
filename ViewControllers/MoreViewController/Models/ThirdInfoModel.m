//
//  ThirdInfoModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ThirdInfoModel.h"

@implementation ThirdDetailModel


@end

@implementation ThirdInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        id info = dic[@"info"];
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            self.info = [[ThirdDetailModel alloc]initWithDictionary:dic[@"info"]];
        }
    }
    return self;
}

@end
@implementation ThirdListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        
        self.weibo = [[ThirdInfoModel alloc]initWithDictionary:dic[@"weibo"]];
        self.weixin = [[ThirdInfoModel alloc]initWithDictionary:dic[@"weixin"]];
        self.qq = [[ThirdInfoModel alloc]initWithDictionary:dic[@"qq"]];
    
    }
    return self;
}


@end
