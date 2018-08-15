//
//  ScoreRankBotomCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/1.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "ScoreListModel.h"
@interface ScoreRankBotomCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIImageView * levelIcon;
@property (nonatomic, strong) UILabel * levelLabel;
@property (nonatomic, strong) UIView * line;
- (void)updateWithScoreRankModel:(ScoreListModel *)model;
@end
