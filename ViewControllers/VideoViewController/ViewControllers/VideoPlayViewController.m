//
//  VideoPlayViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface VideoPlayViewController ()

@property (nonatomic, strong) NSURL * url;

@end

@implementation VideoPlayViewController

- (instancetype)initWithUrl:(NSURL *)url{
    self  = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatPlayer];
}
- (void)creatPlayer{
    self.player = [[AVPlayer alloc]initWithURL:self.url];
    [self.player play];
}
- (void)playUrl:(NSURL *)url{
    self.player = [AVPlayer playerWithURL:url];
    [self.player play];
}



@end
