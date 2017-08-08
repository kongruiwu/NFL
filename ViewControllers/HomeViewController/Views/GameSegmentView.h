//
//  GameSegmentView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HMSegmentedControl.h>
#import "ConfigHeader.h"
@interface GameSegmentView : UIView

@property (nonatomic, strong) HMSegmentedControl * segmentView;
@property (nonatomic, strong) UIImageView * groundImg;

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UIImageView * rightImg;
@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UIView * lineView;

@end
