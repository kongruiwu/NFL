//
//  GameVideoViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"
#import "VideoListModel.h"
@interface GameVideoViewController : GameBassViewController

@property (nonatomic, strong) NSArray<VideoListModel *> * dataArray;
@end