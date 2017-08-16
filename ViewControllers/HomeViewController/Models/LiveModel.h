//
//  LiveModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface LiveDetailModel : BaseModel
/**CAR阵前35码 后缀*/
@property (nonatomic, strong) NSString * yardline;
/**节数  第几节*/
@property (nonatomic, strong) NSString * quarter;
/**内容*/
@property (nonatomic, strong) NSString * content;
/**1档10码  前缀*/
@property (nonatomic, strong) NSString * down_yards;
/**时间*/
@property (nonatomic, strong) NSString * time;

@property (nonatomic, strong) NSNumber * play_id;

@end

@interface LiveModel : BaseModel

@property (nonatomic, strong) NSString * drive;
/**内容数据*/
@property (nonatomic, strong) NSArray<LiveDetailModel *> * list;
/**主队/客队*/
@property (nonatomic, strong) NSString * team;
/**球队名称*/
@property (nonatomic, strong) NSString * team_name;
@end
