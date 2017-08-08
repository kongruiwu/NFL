//
//  VideoDetailModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "VideoListModel.h"
@interface VideoDetailModel : BaseModel

@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * src;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSNumber * time_stamp;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSNumber * collect_num;
@property (nonatomic, strong) NSString * share_link;
@property (nonatomic, strong) NSArray<VideoListModel *> * recommend_list;
@end
