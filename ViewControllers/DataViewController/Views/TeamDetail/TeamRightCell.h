//
//  TeamRightCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PlayerListModel.h"
@interface TeamRightCell : UITableViewCell

@property (nonatomic, strong) UILabel * numlabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UIView * line2;
- (void)updateWitPlayerListModel:(PlayerListModel *)model;
@end
