//
//  TeamRankModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TeamRankModel : BaseModel
/**净胜分*/
@property (nonatomic, strong) NSNumber * net_points;
/**胜球*/
@property (nonatomic, strong) NSNumber * win;
/**排名*/
@property (nonatomic, strong) NSNumber * idx;
/**球队id*/
@property (nonatomic, strong) NSNumber * team_id;
/**平*/
@property (nonatomic, strong) NSNumber * tie;
/**输球*/
@property (nonatomic, strong) NSNumber * lose;
/**名称*/
@property (nonatomic, strong) NSString * name;
/**胜率*/
@property (nonatomic, strong) NSString * win_pct;
@end
