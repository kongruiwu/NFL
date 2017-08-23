//
//  OnlineAnswerModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface OnlineAnswerModel : BaseModel

@property (nonatomic, strong) NSNumber * id;
/**用户id*/
@property (nonatomic, strong) NSNumber * uid;
/**用户姓名*/
@property (nonatomic, strong) NSString * username;
/**头像*/
@property (nonatomic, strong) NSString * avatar;
/**内容*/
@property (nonatomic, strong) NSString * content;
/**是否是管理员*/
@property (nonatomic, assign) BOOL is_admin;
/***/
@property (nonatomic, strong) NSNumber * time;

@end
