//
//  ScoreRankModel.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/3.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "ScoreRankModel.h"

@implementation MissonModel

@end

@implementation ScoreRankModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        if (dic[@"tasks"]) {
            NSDictionary * tasks = dic[@"tasks"];
            NSArray * arr1 = tasks[@"daily"];
            NSArray * arr2 = tasks[@"newbie"];
            NSMutableArray * muarr = [NSMutableArray new];
            self.dailyOverCount = arr1.count;
            self.newbieOverCount = arr2.count;
            for (int i = 0; i<arr1.count; i++) {
                MissonModel * model = [[MissonModel alloc]initWithDictionary:arr1[i]];
                if ([model.title containsString:@"签到"]) {
                    self.signInTask = model;
                }else if([model.title containsString:@"分享"]){
                    self.shareTask = model;
                }
                [muarr addObject:model];
            }
            self.daily = [NSArray arrayWithArray:muarr];
            [muarr removeAllObjects];
            for (int i = 0; i<arr2.count; i++) {
                MissonModel * model = [[MissonModel alloc]initWithDictionary:arr2[i]];
                
                [muarr addObject:model];
            }
            self.newbie = [NSArray arrayWithArray:muarr];
            
            [self updateTaskOverCount];
        }
    }
    return self;
}

- (void)updateTaskOverCount{
    self.dailyOverCount = 0;
    self.newbieOverCount = 0;
    for (int i = 0; i<self.daily.count; i++) {
        if (self.daily[i].completed) {
            self.dailyOverCount += 1;
        }
    }
    for (int i = 0; i<self.newbie.count; i++) {
        if (self.newbie[i].completed) {
            self.newbieOverCount += 1;
        }
    }
}

@end
