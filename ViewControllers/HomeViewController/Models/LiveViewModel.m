//
//  LiveViewModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LiveViewModel.h"

@implementation TeamScoreModel

@end

@implementation TeamStateModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.hold_time = [[TeamScoreModel alloc]initWithDictionary:dic[@"hold_time"]];
        self.rush_yards = [[TeamScoreModel alloc]initWithDictionary:dic[@"rush_yards"]];
        self.turn_over = [[TeamScoreModel alloc]initWithDictionary:dic[@"turn_over"]];
        self.pass_yards = [[TeamScoreModel alloc]initWithDictionary:dic[@"pass_yards"]];
        self.thirddown_rate = [[TeamScoreModel alloc]initWithDictionary:dic[@"thirddown_rate"]];
    }
    return self;
}

@end

@implementation PlayerStateModel

@end

@implementation ScoreModel


@end
@implementation DetailPointModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.visitor = [[ScoreModel alloc]initWithDictionary:dic[@"visitor"]];
        self.home = [[ScoreModel alloc]initWithDictionary:dic[@"home"]];
    }
    return self;
}

@end
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
        
        if (dic[@"news_list"]) {
            arr = dic[@"news_list"];
            [muarr removeAllObjects];
            for (int i = 0; i<arr.count; i++) {
                InfoListModel * model = [[InfoListModel alloc]initWithDictionary:arr[i]];
                [muarr addObject:model];
            }
            self.news_list = [NSArray arrayWithArray:muarr];
        }
        //video_list
        if (dic[@"video_list"]) {
            arr = dic[@"video_list"];
            [muarr removeAllObjects];
            for (int i = 0; i<arr.count; i++) {
                VideoListModel * model = [[VideoListModel alloc]initWithDictionary:arr[i]];
                [muarr addObject:model];
            }
            self.video_list = [NSArray arrayWithArray:muarr];
        }
        if (dic[@"team_state"]) {
            self.team_state = [[TeamStateModel alloc]initWithDictionary:dic[@"team_state"]];
        }
        if (dic[@"player_state"]) {
            self.player_state = [[PlayerStateModel alloc]initWithDictionary:dic[@"player_state"]];
        }
        if (dic[@"detail_point"]) {
            self.detail_point = [[DetailPointModel alloc]initWithDictionary:dic[@"detail_point"]];
        }
        
    }
    return self;
}

@end
