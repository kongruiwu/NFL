//
//  PlayerRankModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PlayerRankModel.h"

@implementation RankPlayer



@end

@implementation PlayerRankModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"rank"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            RankPlayer * player = [[RankPlayer alloc]initWithDictionary:arr[i]];
            [muarr addObject:player];
        }
        self.rank = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
