//
//  UserInfo.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface HomeTeam : BaseModel

@property (nonatomic, strong) NSNumber * team_id;
@property (nonatomic, strong) NSString * team_name;

@end

@interface UserInfo : BaseModel
/**用户名*/
@property (nonatomic, strong) NSNumber * uid;
/**类似token  验证*/
@property (nonatomic, strong) NSString * callback_verify;
/**天天nfl使用*/
@property (nonatomic, strong) NSString * callback_verify_ttnfl;
/**用户名*/
@property (nonatomic, strong) NSString * username;
/**手机*/
@property (nonatomic, strong) NSString * mobile;
/**头像*/
@property (nonatomic, strong) NSString * avatar;
/**性别*/
@property (nonatomic, strong) NSString * gender;
/**地址*/
@property (nonatomic, strong) NSString * city;
/**生日*/
@property (nonatomic, strong) NSString * birthday;
/**主队*/
@property (nonatomic, strong) HomeTeam * home_team;
/**关注的球队*/
@property (nonatomic, strong) NSMutableArray<HomeTeam *> * follow_teams;
@end
