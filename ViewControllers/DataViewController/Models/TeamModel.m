//
//  TeamModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamModel.h"
#import "UserManager.h"
@implementation TeamModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.followed = NO;
        if ([UserManager manager].isLogin) {
            for (int i = 0; i<[UserManager manager].info.follow_teams.count; i++) {
                if ([self.team_id integerValue] == [[UserManager manager].info.follow_teams[i].team_id integerValue]) {
                    self.followed = YES;
                }
            }
        }
    }
    return self;
}

@end
