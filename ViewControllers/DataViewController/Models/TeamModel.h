//
//  TeamModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TeamModel : BaseModel
/**拼音缩写*/
@property (nonatomic, strong) NSString * abbr;
/**名称*/
@property (nonatomic, strong) NSString * name;
/**球队id*/
@property (nonatomic, strong) NSNumber * team_id;
/**简称*/
@property (nonatomic, strong) NSString * sname;
/**是否被关注*/
@property (nonatomic, assign) BOOL followed;

@end
