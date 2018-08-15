//
//  ScoreRankTopCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/31.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "ScoreListModel.h"
@interface ScoreRankTopCell : UITableViewCell

@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIImageView * levelIcon;
@property (nonatomic, strong) UILabel * levelLabel;
@property (nonatomic, strong) UIView * line;
- (void)updateWithScoreRankModel:(ScoreListModel *)model indexRow:(NSInteger)indexrow;
@end
