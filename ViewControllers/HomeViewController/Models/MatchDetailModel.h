//
//  MatchDetailModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
/**转播平台*/
@interface LiveTypeModel : BaseModel
/**标题*/
@property (nonatomic, strong) NSString * title;
/**链接*/
@property (nonatomic, strong) NSString * link;
/**logo图像*/
@property (nonatomic, strong) NSString * logo;

@end


@interface MatchDetailModel : BaseModel

@property (nonatomic, strong) NSNumber * id;
/**比赛id*/
@property (nonatomic, strong) NSNumber * gameId;
/**比赛key*/
@property (nonatomic, strong) NSString * gamekey;
/**主场球队id*/
@property (nonatomic, strong) NSNumber * home_teamId;
/**主场球队得分*/
@property (nonatomic, strong) NSNumber * home_scores;
/**主场球队名称*/
@property (nonatomic, strong) NSString * home_name;
/**客场球队id*/
@property (nonatomic, strong) NSNumber * visitor_teamId;
/**客场得分*/
@property (nonatomic, strong) NSNumber * visitor_scores;
/**客场球队名称*/
@property (nonatomic, strong) NSString * visitor_name;
/**时间？？*/
@property (nonatomic, strong) NSNumber * time;
/**比赛状态（0：未开始，1：正在进行，2;已结束）*/
@property (nonatomic, strong) NSNumber * match_state;

@property (nonatomic, assign) BOOL hasLive;

/**直播地址*/
@property (nonatomic, strong) NSString * live_h5_url;

/**转播平台*/
@property (nonatomic, strong) NSArray<LiveTypeModel *> * relay_list;
/**视屏地址*/
@property (nonatomic, strong) NSString * video;
/**比赛类型*/
@property (nonatomic, strong) NSString * match_type;
/**08/11*/
@property (nonatomic, strong) NSString * c_date;
/**星期几*/
@property (nonatomic, strong) NSString * c_date_w;
@end
