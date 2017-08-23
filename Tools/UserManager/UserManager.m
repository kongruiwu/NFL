//
//  UserManager.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserManager.h"


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
