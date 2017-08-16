//
//  MatchOverDataModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MatchOverDataModel.h"

@implementation TeamScoreModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        
    }
    return self;
}

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

@implementation MatchOverDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.team_state = [[TeamStateModel alloc]initWithDictionary:dic[@"team_state"]];
        self.player_state = [[PlayerStateModel alloc]initWithDictionary:dic[@"player_state"]];
        self.detail_point = [[DetailPointModel alloc]initWithDictionary:dic[@"detail_point"]];
    }
    return self;
}


@end
