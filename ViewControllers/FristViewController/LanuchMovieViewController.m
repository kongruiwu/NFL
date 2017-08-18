//
//  LanuchMovieViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LanuchMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface LanuchMovieViewController ()

@end

@implementation LanuchMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyMovie];
    // Do any additional setup after loading the view.
}

- (void)readyMovie{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"nfl.mp4" ofType:nil];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
    self.showsPlaybackControls = NO;
    [self.player play];
}

@end
