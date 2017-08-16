//
//  GameDetailTabViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
#import "MatchDetailModel.h"
typedef NS_ENUM(NSInteger,MacthStatus){
    MacthStatusReady = 0,       //未开始
    MacthStatusPlaying = 1,     //正在进行
    MacthStatusOver = 2,        //已结束
};

@interface GameDetailTabViewController : BaseViewController

@property (nonatomic) MacthStatus gameStatus;
@property (nonatomic, strong) MatchDetailModel * game;

- (instancetype)initWithMatchDetailModel:(MatchDetailModel *)model;

@end
