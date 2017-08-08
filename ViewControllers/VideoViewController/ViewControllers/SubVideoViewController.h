//
//  SubVideoViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"


typedef NS_ENUM(NSInteger, VideoType){
    VideoTypeBallStar = 0   ,       //球星
    VideoTypeMatch         ,       //赛程
    VideoTypeTidbits        ,       //花絮
    VideoTypeTeach            ,       //101
    VideoTypeInFollow        ,       //关注
};

@interface SubVideoViewController : BaseViewController

@property (nonatomic, assign) VideoType videoType;

@end
