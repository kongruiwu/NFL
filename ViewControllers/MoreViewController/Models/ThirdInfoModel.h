//
//  ThirdInfoModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface ThirdDetailModel : BaseModel

@property (nonatomic, strong) NSString * openid;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * avatar;

@end

@interface ThirdInfoModel : BaseModel
/**是否绑定*/
@property (nonatomic, assign) BOOL binded;
/**三方信息*/
@property (nonatomic, strong) ThirdDetailModel * info;

@end

@interface ThirdListModel : BaseModel

@property (nonatomic, strong) ThirdInfoModel * weixin;
@property (nonatomic, strong) ThirdInfoModel * qq;
@property (nonatomic, strong) ThirdInfoModel * weibo;

@end
