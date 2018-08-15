//
//  ScoreRankModel.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/3.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface MissonModel : BaseModel

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSNumber * exp;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * sub_title;
@property (nonatomic, assign) BOOL completed;

@end


@interface ScoreRankModel : BaseModel
@property (nonatomic, strong) NSNumber * uid;
@property (nonatomic, strong) NSNumber * lv;
@property (nonatomic, strong) NSString * rank;
@property (nonatomic, strong) NSNumber * score_available;
//
@property (nonatomic, strong) NSNumber * score_season;
//总积分
@property (nonatomic, strong) NSNumber * score_total;
//连续签到时间
@property (nonatomic, strong) NSNumber * sign_continu_days;
@property (nonatomic, strong) NSArray<MissonModel *> * daily;
@property (nonatomic, strong) NSArray<MissonModel *> * newbie;
@property (nonatomic, assign) NSInteger dailyOverCount;
@property (nonatomic, assign) NSInteger newbieOverCount;

@property (nonatomic, strong) MissonModel * signInTask;
@property (nonatomic, strong) MissonModel * shareTask;


- (void)updateTaskOverCount;
@end
