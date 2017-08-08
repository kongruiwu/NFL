//
//  GameDataViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"

@protocol GameDataViewControllerDelegate <NSObject>

- (void)hiddenOutHeadView:(CGFloat)y;

@end

@interface GameDataViewController : GameBassViewController


@property (nonatomic, assign) id<GameDataViewControllerDelegate> delegate;

@end
