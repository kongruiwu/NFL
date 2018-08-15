//
//  UserManager.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "ScoreRankModel.h"
@interface UserManager : NSObject
/**用户信息*/
@property (nonatomic, strong) UserInfo * info;
/**用户id*/
@property (nonatomic, strong) NSNumber * userID;
/**用户积分信息*/
@property (nonatomic, strong) ScoreRankModel * score;

/**用户是否登录*/
@property (nonatomic, assign) BOOL isLogin;
/**是否开启无图模式*/
@property (nonatomic, assign) BOOL hasPic;

+ (instancetype)manager;
- (void)updateUserInfo:(NSDictionary *)dic;
- (void)updateInfoByEditstatus:(NSDictionary *)dic;
- (void)userLogOut;
- (void)getUserScoreInfo;
//完成分享任务
- (void)overShareTask;
@end
