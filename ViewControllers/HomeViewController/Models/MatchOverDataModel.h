//
//  MatchOverDataModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TeamScoreModel : BaseModel

@property (nonatomic, strong) NSNumber * visitor;
@property (nonatomic, strong) NSNumber * home;

@end

@interface TeamStateModel : BaseModel

@property (nonatomic, strong) TeamScoreModel * hold_time;
@property (nonatomic, strong) TeamScoreModel * rush_yards;
@property (nonatomic, strong) TeamScoreModel * turn_over;
@property (nonatomic, strong) TeamScoreModel * pass_yards;
@property (nonatomic, strong) TeamScoreModel * thirddown_rate;

@end

@interface PlayerStateModel : BaseModel

@property (nonatomic, strong) NSArray * visitor;
@property (nonatomic, strong) NSArray * home;

@end

@interface ScoreModel : BaseModel

@property (nonatomic, strong) NSNumber * Q1;
@property (nonatomic, strong) NSNumber * Q2;
@property (nonatomic, strong) NSNumber * Q3;
@property (nonatomic, strong) NSNumber * Q4;
@property (nonatomic, strong) NSNumber * OT;
@property (nonatomic, strong) NSNumber * total;
@end

@interface DetailPointModel : BaseModel

@property (nonatomic, strong) ScoreModel * visitor;
@property (nonatomic, strong) ScoreModel * home;

@end

@interface MatchOverDataModel : BaseModel

/**主队名称*/
@property (nonatomic, strong) NSString * home_name;
/**客队得分*/
@property (nonatomic, strong) NSNumber * visitor_scores;
/**球队数据*/
@property (nonatomic, strong) TeamStateModel * team_state;
/**比赛id*/
@property (nonatomic, strong) NSNumber * gameId;
/**主队得分*/
@property (nonatomic, strong) NSNumber * home_scores;
/** ？？ */
@property (nonatomic, strong) NSNumber * time;
/**比赛类型 是否结束*/
@property (nonatomic, strong) NSNumber * match_state;
/**球员 类别*/
@property (nonatomic, strong) PlayerStateModel * player_state;
/**客队id*/
@property (nonatomic, strong) NSNumber * visitor_teamId;
/**得分 对应每一节得分*/
@property (nonatomic, strong) DetailPointModel * detail_point;
/**客队名称*/
@property (nonatomic, strong) NSString * visitor_name;
/**主队id*/
@property (nonatomic, strong) NSNumber * home_teamId;

@end
