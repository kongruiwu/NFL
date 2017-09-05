//
//  AboutUsModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/23.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface AboutInfoModel : BaseModel

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * value;

@end


@interface AboutUsModel : BaseModel

@property (nonatomic, strong) AboutInfoModel * weixin_gz;
@property (nonatomic, strong) AboutInfoModel * weibo;
@property (nonatomic, strong) AboutInfoModel * home_site;
@property (nonatomic, strong) AboutInfoModel * email;

@end
