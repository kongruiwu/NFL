//
//  LiveViewModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LiveViewModel.h"

@implementation StarDetailScoreModel

@end
@implementation StarDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"data_list"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            StarDetailScoreModel * model = [[StarDetailScoreModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.data_list = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end

@implementation StarModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.home = [[StarDetailModel alloc]initWithDictionary:dic[@"home"]];
        self.visitor = [[StarDetailModel alloc]initWithDictionary:dic[@"visitor"]];
    }
    return self;
}

@end

@implementation MatchScoreModel


@end


@implementation VsLogModel


@end

@implementation ParamsModel


@end

@implementation LiveViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"play_by_play"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            LiveModel * model = [[LiveModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.play_by_play = [NSMutableArray arrayWithArray:muarr];
        
        arr = dic[@"page_list"];
        [muarr removeAllObjects];
        for (int i = 0; i<arr.count; i++) {
            ParamsModel * model = [[ParamsModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.page_list = [NSArray arrayWithArray:muarr];
        
        if (dic[@"vs_log"]) {
            arr = dic[@"vs_log"];
            [muarr removeAllObjects];
            for (int i = 0; i<arr.count; i++) {
                VsLogModel * model = [[VsLogModel alloc]initWithDictionary:arr[i]];
                [muarr addObject:model];
            }
            self.vs_log = [NSArray arrayWithArray:muarr];
        }
        
        if (dic[@"offensive_yards"]) {
            self.offensive_yards = [[MatchScoreModel alloc]initWithDictionary:dic[@"offensive_yards"]];
        }
        if (dic[@"defense_points"]) {
            self.defense_points = [[MatchScoreModel alloc]initWithDictionary:dic[@"defense_points"]];
        }
        if (dic[@"offensive_points"]) {
            self.offensive_points = [[MatchScoreModel alloc]initWithDictionary:dic[@"offensive_points"]];
        }
        if (dic[@"defense_yards"]) {
            self.defense_yards = [[MatchScoreModel alloc]initWithDictionary:dic[@"defense_yards"]];
        }
        if (dic[@"stars"]) {
            self.stars = [[StarModel alloc]initWithDictionary:dic[@"stars"]];
        }
    }
    return self;
}

@end
