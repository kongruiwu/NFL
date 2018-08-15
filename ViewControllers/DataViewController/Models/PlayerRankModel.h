//
//  PlayerRankModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"


@interface RankPlayer : BaseModel

@property (nonatomic, strong) NSNumber * idx;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * team_name;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * stats1;
@property (nonatomic, strong) NSString * stats2;
@property (nonatomic, strong) NSString * stats3;
@end

@interface Stats :BaseModel

@property (nonatomic, strong) NSString * sk;
@property (nonatomic, strong) NSString * sn;

@end

@interface PlayerRankModel : BaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray<RankPlayer *> * rank;
@property (nonatomic, strong) NSArray<Stats *> * stats;

@end
