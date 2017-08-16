//
//  PlayerView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/13.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

+ (instancetype)playView{
    static PlayerView * playview = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!playview) {
            playview = [[PlayerView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(420))];
        }
    });
//    if (playview) {
//        [playview removeFromSuperview];
//    }
    return playview;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.blackView = [Factory creatViewWithColor:[UIColor blackColor]];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.loadView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.loadView.center = self.center;
        [self.blackView addSubview:self.loadView];
        [self.loadView startAnimating];
        [self.loadView setHidesWhenStopped:YES];
        self.blackView.frame = frame;
        [self addSubview:self.blackView];
    }
    return self;
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self.player pause];
    [self bringSubviewToFront:self.blackView];
}

- (void)setUpPlayer:(NSArray *)arr{
    if (!self.player) {
        NSMutableArray * muarr = [[NSMutableArray alloc]init];
        for (int i = 0; i<arr.count; i++) {
            AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:arr[i]]];
            [muarr addObject:item];
        }
        self.player = [AVQueuePlayer queuePlayerWithItems:muarr];
        self.player.actionAtItemEnd = AVPlayerItemStatusReadyToPlay;
        self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playLayer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(420));
        [self.layer addSublayer:self.playLayer];
        
        [self.player play];
    }
}
- (void)playVideoWithUrl:(NSString *)url{
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
    if ([self.player canInsertItem:item afterItem:self.player.currentItem]) {
        [self.player insertItem:item afterItem:self.player.currentItem];
    }
    [self.player advanceToNextItem];
    [self.player play];
    self.blackView.hidden = YES;
    //移除上一个 视屏对象，保证整个视频队列中只有一个视频item
}
- (void)nextVideo{
    [self.player advanceToNextItem];
}
@end
