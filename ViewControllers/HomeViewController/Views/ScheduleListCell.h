//
//  ScheduleListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"


@interface ScheduleListCell : UITableViewCell


@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * leftName;

@property (nonatomic, strong) UIImageView * rightImg;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UILabel * rightName;

@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * statusLabel;

//视屏标签  未开赛时 使用
@property (nonatomic, strong) NSArray * tagImgs;
//精彩视频
@property (nonatomic, strong) UIButton * videoButton;

@property (nonatomic, strong) UIView * line;

@end
