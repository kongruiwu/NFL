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

@implementation Stats

@end

@implementation PlayerRankModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"rank"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            RankPlayer * player = [[RankPlayer alloc]initWithDictionary:arr[i]];
            if (player.stats3.length > 3) {
                NSMutableString * mustr = [[NSMutableString alloc]initWithString:player.stats3];
                player.stats3 = [mustr substringToIndex:3];
            }
            if (player.name && player.name.length > 0) {
                [muarr addObject:player];
            }
        }
        self.rank = [NSArray arrayWithArray:muarr];
        
        NSArray * arr2 = dic[@"stats"];
        [muarr removeAllObjects];
        for (int i = 0 ; i<arr2.count; i++) {
            Stats * stats = [[Stats alloc] initWithDictionary:arr2[i]];
            [muarr addObject:stats];
        }
        self.stats = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
