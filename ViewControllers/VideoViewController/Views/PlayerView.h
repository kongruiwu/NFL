//
//  PlayerView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/13.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ConfigHeader.h"
@interface PlayerView : UIView


@property (nonatomic, strong) AVQueuePlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playLayer;
@property (nonatomic, strong) UIActivityIndicatorView * loadView;
@property (nonatomic, strong) UIView * blackView;
+ (instancetype)playView;
- (void)setUpPlayer:(NSArray *)arr;
- (void)playVideoWithUrl:(NSString *)url;
- (void)nextVideo;
@end
