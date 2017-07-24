//
//  TeamerRankListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface TeamerRankListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectView;

@end
