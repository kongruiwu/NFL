//
//  GameLiveViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"
#import "LiveViewModel.h"

@interface GameLiveViewController : GameBassViewController
@property (nonatomic, strong) LiveViewModel * viewModel;
@end
