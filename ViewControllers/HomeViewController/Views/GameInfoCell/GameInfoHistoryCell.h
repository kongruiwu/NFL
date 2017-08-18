//
//  GameInfoHistoryCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "LiveViewModel.h"
@interface GameInfoHistoryCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UIImageView * rightImg;
@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIView * lineView;

- (void)updateWithLiveViewModel:(VsLogModel *)model;
@end
