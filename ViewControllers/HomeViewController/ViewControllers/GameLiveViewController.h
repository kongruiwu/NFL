//
//  GameLiveViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"
#import "LiveModel.h"

@interface GameLiveViewController : GameBassViewController

@property (nonatomic) BOOL isPlaying;
@property (nonatomic, strong) NSArray<LiveModel *> * dataArrays;

@end
