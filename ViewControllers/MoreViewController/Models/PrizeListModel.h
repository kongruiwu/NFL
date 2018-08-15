//
//  PrizeListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/14.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PrizeListModel : BaseModel
@property (nonatomic, strong) NSNumber * id;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * pic;
//花费？
@property (nonatomic, strong) NSNumber * cost;
//是否兑换过
@property (nonatomic, assign) BOOL exchanged;

@end
