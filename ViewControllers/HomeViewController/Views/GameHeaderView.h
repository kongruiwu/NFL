//
//  GameHeaderView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import <HMSegmentedControl.h>
#import "MatchDetailModel.h"
@interface GameHeaderView : UIView

@property (nonatomic, strong) UIImageView * groundImg;
@property (nonatomic, strong) UIImageView * blueImg;
@property (nonatomic, strong) HMSegmentedControl * segmentView;

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UIImageView * rightImg;
@property (nonatomic, strong) UILabel * leftName;
@property (nonatomic, strong) UILabel * rightName;
@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UILabel * gameStatus;
@property (nonatomic, strong) UILabel * vsLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UIButton * videoButton;

- (void)updateWithMatchDetailModel:(MatchDetailModel *)model;

@end
