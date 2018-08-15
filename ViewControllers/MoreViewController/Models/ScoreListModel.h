//
//  ScoreListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface ScoreListModel : BaseModel
@property (nonatomic, strong) NSNumber * rank;
@property (nonatomic, strong) NSNumber * uid;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSNumber * lv;
@property (nonatomic, strong) NSNumber * score;
@property (nonatomic, strong) NSString * avatar;
@end
