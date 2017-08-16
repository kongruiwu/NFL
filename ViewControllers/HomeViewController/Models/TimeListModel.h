//
//  TimeListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TimeListModel : BaseModel
/**持续时间*/
@property (nonatomic, strong) NSNumber * week;
/**比赛类型*/
@property (nonatomic, strong) NSString * match_type;
/**日期字符串*/
@property (nonatomic, strong) NSString * date_str;
/**标题*/
@property (nonatomic, strong) NSString * title;
/**是否被选择*/
@property (nonatomic) BOOL isSelect;
@end
