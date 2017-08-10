//
//  PhotoListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/9.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoListModel : BaseModel

@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSNumber * num;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSNumber * collect_num;

@end
