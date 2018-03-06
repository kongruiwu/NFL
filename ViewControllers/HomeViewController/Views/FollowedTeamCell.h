//
//  FollowedTeamCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "UserInfo.h"
@interface FollowedTeamCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, assign) BOOL isWhite;

@property (nonatomic, strong) UILabel * descLabel;

@property (nonatomic, strong) UICollectionView * collectView;

@property (nonatomic, strong) NSArray * dataArray;

@end
