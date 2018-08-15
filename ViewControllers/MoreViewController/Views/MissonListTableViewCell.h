//
//  MissonListTableViewCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/31.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface MissonListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UILabel * overLabel;

- (void)updateWithMissonModel:(MissonModel *)model;

@end
