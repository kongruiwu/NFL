//
//  InfoMainModel.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"
#import "InfoListModel.h"
@interface InfoCoverModel : BaseModel
/**数据类型*/
@property (nonatomic, strong) NSString * cont_type;
@property (nonatomic, strong) NSNumber * id;
/**标题*/
@property (nonatomic, strong) NSString * title;
/**封面*/
@property (nonatomic, strong) NSString * pic;

@end


@interface InfoMainModel : BaseModel
/**只会在第一次加载时返回*/
@property (nonatomic, strong) InfoCoverModel * coverModel;
@property (nonatomic, strong) NSArray<InfoListModel *> * list;

@end
