//
//  SubTeamRankModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface SubTeamRankModel : BaseModel
/**联盟战绩*/
@property (nonatomic, strong) NSString * conference_record;
/**外部战绩*/
@property (nonatomic, strong) NSString * non_conference_record;
/**分区胜率*/
@property (nonatomic, strong) NSString * division_win_pct;
/**排名*/
@property (nonatomic, strong) NSNumber * idx;
/**球队id*/
@property (nonatomic, strong) NSNumber * team_id;
/**球队名称*/
@property (nonatomic, strong) NSString * name;
/**分区战绩*/
@property (nonatomic, strong) NSString * division_record;
@end
