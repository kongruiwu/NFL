//
//  LiveViewModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "LiveModel.h"
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
@property (nonatomic, strong) NSArray * page_list;
/**客队id*/
@property (nonatomic, strong) NSNumber * visitor_teamId;
/**直播内容*/
@property (nonatomic, strong) NSArray<LiveModel *> * play_by_play;
/**当前界面 对应key*/
@property (nonatomic, strong) NSString * page;
/**课程名称*/
@property (nonatomic, strong) NSString * visitor_name;
/**主队id*/
@property (nonatomic, strong) NSNumber * home_teamId;
@end
