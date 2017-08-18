//
//  HomeInfoModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
@interface InfoParams :BaseModel

@property (nonatomic, strong) NSString * match_type;
@property (nonatomic, strong) NSNumber * week;

@end


@interface HomeInfoModel : BaseModel

@property (nonatomic, strong) InfoParams * pre;
@property (nonatomic, strong) InfoParams * index;
@property (nonatomic, strong) InfoParams * next;

@end
