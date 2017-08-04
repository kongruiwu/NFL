//
//  GameLiveListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface GameLiveListCell : UITableViewCell

@property (nonatomic, strong) UIView * leftLine;
@property (nonatomic, strong) UIView * crycleView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * sectionLabel;


@end
