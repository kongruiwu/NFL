//
//  LanuchMovieViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LanuchMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FristViewController.h"
#import "ConfigHeader.h"
#import "RootViewController.h"
@interface LanuchMovieViewController ()

@property (nonatomic) BOOL rec;

@end

@implementation LanuchMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyMovie];
    [self creatUI];
    
}
- (void)creatUI{
    self.rec = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkFirstView];
    });
    
    
    UIButton * button = [Factory creatButtonWithTitle:@"跳过"
                                      backGroundColor:UIColorFromRGBA(0xFFFFFF, 0.4)
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(26)];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = Anno750(30);
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.top.equalTo(@64);
        make.width.equalTo(@(Anno750(150)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [button addTarget:self action:@selector(checkFirstView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)readyMovie{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"nflvideo.mp4" ofType:nil];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
    self.showsPlaybackControls = NO;
    [self.player play];
}
- (void)checkFirstView{
    if (self.rec) {
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Frist"]) {
        [[UIApplication sharedApplication].keyWindow setRootViewController:[FristViewController new]];
    }else{
        [[UIApplication sharedApplication].keyWindow setRootViewController:[RootViewController new]];
    }
    self.rec = YES;
}

@end
