//
//  InfoListModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface InfoListModel : BaseModel
/**类型*/
@property (nonatomic, strong) NSString * cont_type;
@property (nonatomic, strong) NSNumber * id;
/**标题*/
@property (nonatomic, strong) NSString * title;
/**封面*/
@property (nonatomic, strong) NSString * pic;
/**缩略图？*/
@property (nonatomic, strong) NSString * pic_thumbnail;
/**时间戳*/
@property (nonatomic, strong) NSNumber * time_stamp;
/**时间*/
@property (nonatomic, strong) NSString * time;
/**收藏数*/
@property (nonatomic, strong) NSNumber * collect_num;
/**新闻链接*/
@property (nonatomic, strong) NSString * app_iframe;
/**分享链接*/
@property (nonatomic, strong) NSString * share_link;
/**是否收藏*/
@property (nonatomic, assign) BOOL collected;

@end
