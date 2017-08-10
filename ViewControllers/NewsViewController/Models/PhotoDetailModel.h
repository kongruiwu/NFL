//
//  PhotoDetailModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoModel : BaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * pic;

@end

@interface PhotoDetailModel : BaseModel

@property (nonatomic, strong) NSString * album_id;
@property (nonatomic, strong) NSString * album_title;
@property (nonatomic, strong) NSString * share_link;
@property (nonatomic, strong) NSNumber * collect_num;
@property (nonatomic, strong) NSNumber * photo_num;
@property (nonatomic, strong) NSArray<PhotoModel *> * list;
@end
