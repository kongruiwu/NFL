//
//  GameBassViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

@protocol  GameBassDelegate <NSObject>

- (void)hiddenOutHeadView:(CGFloat)y;

@end

//比赛详情基类
@interface GameBassViewController : BaseViewController

@property (nonatomic, strong) UITableView * tabview;

@property (nonatomic, assign) id<GameBassDelegate> delegate;


- (void)updateTabFooter;
@end
