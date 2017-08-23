//
//  TeamDataModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TeamDataInfoModel : BaseModel

/**
 排名基数  为32
 防传数值
 */
@property (nonatomic, strong) NSNumber * defense_pass;
@property (nonatomic, strong) NSNumber * defense_pass_rank;
@property (nonatomic, strong) NSNumber * defense_pass_percent;
/**防跑*/
@property (nonatomic, strong) NSNumber * defense_rush;
@property (nonatomic, strong) NSNumber * defense_rush_rank;
@property (nonatomic, strong) NSNumber * defense_rush_percent;
/**防守*/
@property (nonatomic, strong) NSNumber * defense_points;
@property (nonatomic, strong) NSNumber * defense_points_rank;
@property (nonatomic, strong) NSNumber * defense_points_percent;
/**传球*/
@property (nonatomic, strong) NSNumber * offensive_pass;
@property (nonatomic, strong) NSNumber * offensive_pass_rank;
@property (nonatomic, strong) NSNumber * offensive_pass_percent;
/**进攻得分*/
@property (nonatomic, strong) NSNumber * offensive_points;
@property (nonatomic, strong) NSNumber * offensive_points_rank;
@property (nonatomic, strong) NSNumber * offensive_points_percent;
/**跑球*/
@property (nonatomic, strong) NSNumber * offensive_rush;
@property (nonatomic, strong) NSNumber * offensive_rush_rank;
@property (nonatomic, strong) NSNumber * offensive_rush_percent;

@end


@interface TeamDataModel : BaseModel
/**全称*/
@property (nonatomic, strong) NSString * full_name;
/**创建时间*/
@property (nonatomic, strong) NSString * found_date;
/**球队视频介绍地址*/
@property (nonatomic, strong) NSString * intro_video_src;
/**所属*/
@property (nonatomic, strong) NSString * area;
/**球场*/
@property (nonatomic, strong) NSString * stadium;
/**是否关注*/
@property (nonatomic, assign) BOOL followed;
/**胜场*/
@property (nonatomic, strong) NSNumber * win;
/**败场*/
@property (nonatomic, strong) NSNumber * lose;

@property (nonatomic, strong) NSString * page;
/**球队id*/
@property (nonatomic, strong) NSNumber * team_id;
/**简称*/
@property (nonatomic, strong) NSString * sname;
/**全称*/
@property (nonatomic, strong) NSString * name;
/**地址*/
@property (nonatomic, strong) NSString * place;
/**数据详情*/
@property (nonatomic, strong) TeamDataInfoModel * data_info;
@end
