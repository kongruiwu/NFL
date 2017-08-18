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
        if (!self.gameId) {
            self.gameId = dic[@"game_id"];
        }
        if (!self.home_teamId) {
            self.home_teamId = dic[@"home_id"];
        }
        if (!self.visitor_teamId) {
            self.visitor_teamId = dic[@"visitor_id"];
        }
    }
    return self;
}

@end
