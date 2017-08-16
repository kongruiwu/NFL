//
//  MatchDetailModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MatchDetailModel.h"
@implementation LiveTypeModel


@end


@implementation MatchDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"relay_list"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            LiveTypeModel * model = [[LiveTypeModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.relay_list = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
