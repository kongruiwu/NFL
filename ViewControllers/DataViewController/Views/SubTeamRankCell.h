//
//  SubTeamRankCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "SubTeamRankModel.h"
@interface SubTeamRankCell : UITableViewCell

@property (nonatomic, strong) UILabel * rankNum;
@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * subScore;
@property (nonatomic, strong) UILabel * winProgress;
@property (nonatomic, strong) UILabel * unionScore;
@property (nonatomic, strong) UILabel * outScore;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIView * bottomLine;
- (void)updateWithSubTeamRankModel:(SubTeamRankModel *)model;
@end
