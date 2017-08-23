//
//  ScheduleListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "MatchDetailModel.h"

@protocol ScheduleListCellDelegate <NSObject>

- (void)checkOverMatchVideo:(UIButton *)btn;

@end

@interface ScheduleListCell : UITableViewCell


@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * leftName;

@property (nonatomic, strong) UIImageView * rightImg;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UILabel * rightName;

@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * statusLabel;

@property (nonatomic, strong) UILabel * vsLabel;

//视屏标签  未开赛时 使用
@property (nonatomic, strong) NSMutableArray * tagImgs;
//精彩视频
@property (nonatomic, strong) UIButton * videoButton;

@property (nonatomic, strong) UIView * line;

@property (nonatomic, assign) id<ScheduleListCellDelegate> delgate;


- (void)updateWithMatchDetailModel:(MatchDetailModel *)model;

@end
