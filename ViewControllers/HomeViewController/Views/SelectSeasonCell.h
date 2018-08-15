//
//  SelectSeasonCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/4/2.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface SelectSeasonCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * selectImg;
- (void)updateWithSeason:(NSInteger)season isSelect:(BOOL)rec;
@end
