//
//  SubNewsHeadCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "InfoMainModel.h"
@interface SubNewsHeadCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UILabel * nameLabel;
- (void)updateWithModel:(InfoCoverModel *)model;
@end
