//
//  PrizeHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface PrizeHeader : UIView

@property (nonatomic, strong) UIImageView * backImg;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UILabel * descLabel;


- (void)updateScore;
@end
