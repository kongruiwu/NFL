//
//  TeamerRankListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PlayerRankModel.h"
@interface TeamerRankListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectView;

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) UILabel * rankLabel;
@property (nonatomic, strong) UIImageView * teamerIcon;
@property (nonatomic, strong) UILabel * userName;
@property (nonatomic, strong) UILabel * teamName;
@property (nonatomic, strong) UILabel * passLabel;
@property (nonatomic, strong) UILabel * arriveLabel;
@property (nonatomic, strong) UILabel * stopLabel;
@property (nonatomic, strong) UIView * line;



- (void)updateWithRankPlayer:(RankPlayer *)player;
@end
