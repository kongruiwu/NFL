//
//  SelectTimeCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "TimeListModel.h"
@interface SelectTimeCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIImageView * selectImg;
@property (nonatomic, strong) UIView * lineView;
- (void)updateWithTimeListModel:(TimeListModel *)model;
@end
