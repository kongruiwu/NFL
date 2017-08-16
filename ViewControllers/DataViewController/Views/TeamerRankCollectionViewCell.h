//
//  TeamerRankCollectionViewCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PlayerRankModel.h"
@interface TeamerRankCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * rankNum;
@property (nonatomic, strong) UIImageView * teamerImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * teamLabel;
- (void)updateWithRankPlayer:(RankPlayer *)player;
@end
