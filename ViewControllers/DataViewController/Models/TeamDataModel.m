//
//  TeamDataModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDataModel.h"

@implementation TeamDataInfoModel



@end

@implementation TeamDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSDictionary * dataInfo = dic[@"data_info"];
        self.data_info = [[TeamDataInfoModel alloc]initWithDictionary:dataInfo];
    }
    return self;
}

@end
