//
//  UserInfo.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserInfo.h"

@implementation HomeTeam



@end

@implementation UserInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSDictionary * hometeam = dic[@"home_team"];
        self.home_team = [[HomeTeam alloc]initWithDictionary:hometeam];
        NSArray * arr = dic[@"follow_teams"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            HomeTeam * model = [[HomeTeam alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.follow_teams = [NSMutableArray arrayWithArray:muarr];
    }
    return self;
}

@end
