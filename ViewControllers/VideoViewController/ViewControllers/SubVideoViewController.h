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
    VideoTypeSchedu         ,       //赛程
    VideoTypeTidbits        ,       //花絮
    VideoType101            ,       //101
    
};

@interface SubVideoViewController : BaseViewController

@end
