//
//  PlayerLineUpModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PlayerLineUpModel : BaseModel
/**首发*/
@property (nonatomic, strong) NSString * first;
/**位置*/
@property (nonatomic, strong) NSString * position;
/**替补*/
@property (nonatomic, strong) NSArray * alternates;
@end
