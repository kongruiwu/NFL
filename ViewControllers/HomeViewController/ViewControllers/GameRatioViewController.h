//
//  GameRatioViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"
#import "LiveViewModel.h"
@interface GameRatioViewController : GameBassViewController
@property (nonatomic, strong) LiveViewModel * viewModel;
@property (nonatomic, strong) NSNumber * gameID;

@end
