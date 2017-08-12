//
//  VideoPlayer.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/12.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer : AVPlayer

@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@end
