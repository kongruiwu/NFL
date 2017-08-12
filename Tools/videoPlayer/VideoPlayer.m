//
//  VideoPlayer.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/12.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

+ (instancetype)playerWithURL:(NSURL *)URL{
    VideoPlayer * player = [super playerWithURL:URL];
    if (player) {
        player.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    }
    return player;
}
@end
