//
//  UserManager.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserManager.h"
#import "ConfigHeader.h"

@implementation UserManager

+ (instancetype)manager{
    static UserManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[UserManager alloc]init];
            id uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
            if (uid) {
                manager.isLogin = YES;
                manager.userID = (NSNumber *)uid;
            }else{
                manager.isLogin = NO;
            }
            id pic = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasPic"];
            if (pic) {
                NSNumber * num = pic;
                manager.hasPic = [num boolValue];
            }else{
                manager.hasPic = YES;
            }
        }
    });
    return manager;
}

- (void)updateUserInfo:(NSDictionary *)dic{
    self.info = [[UserInfo alloc]initWithDictionary:dic];
    self.userID = self.info.uid;
    [[NSUserDefaults standardUserDefaults] setObject:self.userID forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.isLogin = YES;
    
    [self getUserScoreInfo];
}

- (void)getUserScoreInfo{
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              };
    [[NetWorkManger manager] sendRequest:ScoreInfo route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        [UserManager manager].score = [[ScoreRankModel alloc]initWithDictionary:result[@"data"]];
    } error:^(NFError *byerror) {
    }];
}
- (void)overShareTask{
    if (!self.isLogin) {
        return;
    }
    if (self.score.shareTask.completed) {
        return;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].info.uid,
                              @"task":[UserManager manager].score.shareTask.code
                              };
    [[NetWorkManger manager] sendRequest:Page_CompleteTask route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:[UIApplication sharedApplication].keyWindow withIcon:APToastIconNone text:[NSString stringWithFormat:@"完成分享任务：获得%@积分",self.score.shareTask.exp] duration:2.0f];
        [UserManager manager].score.shareTask.completed = YES;
        
    } error:^(NFError *byerror) {
        
    }];
}

- (void)userLogOut{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.userID = nil;
    self.info = nil;
    self.isLogin = NO;
}
/**这里是用来保存 用户在编辑帐号信息时使用*/
- (void)updateInfoByEditstatus:(NSDictionary *)dic{
    self.info = [[UserInfo alloc]initWithDictionary:dic];
    self.userID = self.info.uid;
}
@end
