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

@end

@interface PlayerRankModel : BaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray<RankPlayer *> * rank;

@end
