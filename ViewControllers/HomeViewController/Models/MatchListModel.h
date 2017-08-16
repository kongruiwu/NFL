//
//  MatchListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "MatchDetailModel.h"

@interface MatchListModel : BaseModel
/** 周一   周二。。。。*/
@property (nonatomic, strong) NSString * c_date_w;
/**日期*/
@property (nonatomic, strong) NSString * c_date;
/**比赛种类  英文*/
@property (nonatomic, strong) NSString * match_type;
/**比赛种类  中文*/
@property (nonatomic, strong) NSString * match_type_cn;
/**周数*/
@property (nonatomic, strong) NSNumber * week;
/**比赛列表*/
@property (nonatomic, strong) NSArray<MatchDetailModel *> * list;
/**2017-08-01*/
@property (nonatomic, strong) NSString * date;
@end
