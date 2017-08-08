//
//  GameLiveViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"

@protocol GameLiveViewControllerDelegate <NSObject>

- (void)hiddenOutHeadView:(CGFloat)y;

@end

@interface GameLiveViewController : GameBassViewController

@property (nonatomic, assign) id<GameLiveViewControllerDelegate> delegate;
@end
