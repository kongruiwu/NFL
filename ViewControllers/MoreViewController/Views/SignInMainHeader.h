//
//  SignInMainHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/30.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "ScoreRankModel.h"
@interface SignInMainHeader : UIView
@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * levelLabel;
@property (nonatomic, strong) UIImageView * levelIcon;

@property (nonatomic, strong) UIButton * prizeBtn;
@property (nonatomic, strong) UIImageView * prizeBg;
@property (nonatomic, strong) UIImageView * prizeIcon;
@property (nonatomic, strong) UILabel * prizeName;
@property (nonatomic, strong) UIImageView * nextIcon;

@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UILabel * scoreName;
@property (nonatomic, strong) UILabel * dayCount;
@property (nonatomic, strong) UILabel * dayName;
@property (nonatomic, strong) UILabel * rankNum;
@property (nonatomic, strong) UILabel * rankName;
@property (nonatomic, strong) UIButton * rankBtn;
@property (nonatomic, strong) UILabel * missonNum;
@property (nonatomic, strong) UIButton * todayMisson;
@property (nonatomic, strong) UIButton * playerMisson;


- (void)updateWithScoreRankModel:(ScoreRankModel *)model isDaily:(BOOL)rec;
@end
