//
//  LiveViewModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "LiveModel.h"
#import "InfoListModel.h"
#import "VideoListModel.h"
//#import "MatchOverDataModel.h"

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

@interface StarDetailScoreModel : BaseModel

@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSString * value;

@end

@interface StarDetailModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * avatar;
/**分数*/
@property (nonatomic, strong) NSArray<StarDetailScoreModel *> * data_list;
@end

@interface StarModel : BaseModel

@property (nonatomic, strong) StarDetailModel * home;
@property (nonatomic, strong) StarDetailModel * visitor;

@end

@interface MatchScoreModel : BaseModel

@property (nonatomic, strong) NSNumber * home;
@property (nonatomic, strong) NSNumber * visitor;

@end


@interface VsLogModel : BaseModel

@property (nonatomic, strong) NSNumber * gameId;
@property (nonatomic, strong) NSNumber * home_teamId;
@property (nonatomic, strong) NSNumber * visitor_scores;
@property (nonatomic, strong) NSNumber * time;
@property (nonatomic, strong) NSNumber * home_scores;
@property (nonatomic, strong) NSNumber * visitor_teamId;
@property (nonatomic, strong) NSString * visitor_name;
@property (nonatomic, strong) NSString * home_name;

@end

@interface ParamsModel : BaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * page;

@end


@interface LiveViewModel : BaseModel
/**主队名称*/
@property (nonatomic, strong) NSString * home_name;
/**客队得分*/
@property (nonatomic, strong) NSNumber * visitor_scores;
/**比赛id*/
@property (nonatomic, strong) NSNumber * gameId;
/**主队得分*/
@property (nonatomic, strong) NSNumber * home_scores;
/**时间*/
@property (nonatomic, strong) NSNumber * time;
/**比赛状态*/
@property (nonatomic, strong) NSNumber * match_state;
/**分页列表*/
@property (nonatomic, strong) NSArray<ParamsModel *> * page_list;
/**客队id*/
@property (nonatomic, strong) NSNumber * visitor_teamId;
/**当前界面 对应key*/
@property (nonatomic, strong) NSString * page;
/**课程名称*/
@property (nonatomic, strong) NSString * visitor_name;
/**主队id*/
@property (nonatomic, strong) NSNumber * home_teamId;

/**战报内容*/
@property (nonatomic, strong) NSMutableArray<LiveModel *> * play_by_play;

//对阵信息
/**天天nfl链接*/
@property (nonatomic, strong) NSString * ttnfl_link;
/**对阵信息数据*/
@property (nonatomic, strong) NSArray<VsLogModel *> * vs_log;
/**转播平台*/
@property (nonatomic, strong) NSString * relay_platform;
/**比赛地点*/
@property (nonatomic, strong) NSString * game_place;
/**比赛时间*/
@property (nonatomic, strong) NSString * game_time_str;


//数据对比
/**场均码数*/
@property (nonatomic, strong) MatchScoreModel * offensive_yards;
/**场均对手得分*/
@property (nonatomic, strong) MatchScoreModel * defense_points;
/**场均得分*/
@property (nonatomic, strong) MatchScoreModel * offensive_points;
/**场均对手码数*/
@property (nonatomic, strong) MatchScoreModel * defense_yards;
/**球星*/
@property (nonatomic, strong) StarModel * stars;

//资讯信息
@property (nonatomic, strong) NSArray<InfoListModel *> * news_list;

//视频列表
@property (nonatomic, strong) NSArray<VideoListModel *> * video_list;

//数据详情
/**球队数据*/
@property (nonatomic, strong) TeamStateModel * team_state;
/**球员 类别*/
@property (nonatomic, strong) PlayerStateModel * player_state;
/**得分 对应每一节得分*/
@property (nonatomic, strong) DetailPointModel * detail_point;
@end
