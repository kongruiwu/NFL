//
//  UserInfo.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo : BaseModel
/**用户名*/
@property (nonatomic, strong) NSNumber * uid;
/**类似token  验证*/
@property (nonatomic, strong) NSString * callback_verify;
/**类似token  验证*/
@property (nonatomic, strong) NSString * callback_verify_ttnfl;
/**用户名*/
@property (nonatomic, strong) NSString * username;
/**手机*/
@property (nonatomic, strong) NSString * mobile;

@end
