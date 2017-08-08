//
//  VideoListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface VideoListModel : BaseModel
/**类型*/
@property (nonatomic, strong) NSString * cont_type;
@property (nonatomic, strong) NSNumber * id;
/**图片*/
@property (nonatomic, strong) NSString * pic;
/**标题*/
@property (nonatomic, strong) NSString * title;
/**视频地址*/
@property (nonatomic, strong) NSString * src;
/**时间戳*/
@property (nonatomic, strong) NSNumber * time_stamp;
/**日期*/
@property (nonatomic, strong) NSString * time;
/**收藏数*/
@property (nonatomic, strong) NSString * collect_num;
@end
