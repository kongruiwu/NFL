//
//  UnionTeamRankCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Factory.h"
#import "TeamRankModel.h"
@interface UnionTeamRankCell : UITableViewCell

@property (nonatomic, strong) UILabel * rankNum;
@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIView * centerLine;
@property (nonatomic, strong) UIView * bottomLine;
//胜球
@property (nonatomic, strong) UILabel * winLabel;
//负
@property (nonatomic, strong) UILabel * loseLabel;
//平
@property (nonatomic, strong) UILabel * drawLabel;
//胜率
@property (nonatomic, strong) UILabel * winProLabel;
//净胜分
@property (nonatomic, strong) UILabel * winScore;
- (void)updateWithTeamRankModel:(TeamRankModel *)model;
@end
