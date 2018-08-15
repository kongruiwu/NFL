//
//  PrizeHeaderCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PrizeListModel.h"
@interface PrizeHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UIImageView * prizeIcon;
@property (nonatomic, strong) UILabel * prizeName;
@property (nonatomic, strong) UILabel * scoreLabel;
- (void)updateWithPrizeListModel:(PrizeListModel *)model;

@end
