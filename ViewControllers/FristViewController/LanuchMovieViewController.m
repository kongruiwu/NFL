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
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) AVPlayerItem * playItem;

@property (nonatomic, strong) UIImageView * backImg;
@property (nonatomic, strong) UIImageView * starImg;
@end

@implementation LanuchMovieViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player play];
    [self addAudioPlayObserver:self.playItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyMovie];
    [self creatUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playItem removeObserver:self forKeyPath:@"status"];
}
- (void)creatUI{
    self.rec = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkFirstView];
    });
    UIImage * image;
    NSString * url = [[NSUserDefaults standardUserDefaults] objectForKey:@"starImg"];
    if (url) {
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/star.png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    if (!image) {
        image = [UIImage imageNamed:@"def"];
    }

    self.starImg = [[UIImageView alloc]initWithImage:image];
    
    self.backImg = [Factory creatImageViewWithImage:@"sta"];
    self.backImg.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT);
    [self.view addSubview:self.backImg];
    [self.backImg addSubview:self.starImg];
    [self.starImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(1174)));
    }];
    
    UIButton * button = [Factory creatButtonWithTitle:@"跳过"
                                      backGroundColor:UIColorFromRGBA(0xFFFFFF, 0.4)
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(26)];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = Anno750(30);
    self.button = button;
    self.button.hidden =YES;
    [self.view addSubview:self.button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.top.equalTo(@64);
        make.width.equalTo(@(Anno750(150)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [button addTarget:self action:@selector(checkFirstView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)readyMovie{
    NSLog(@"readyMovie");
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"nflvideo.mp4" ofType:nil];
    self.playItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:filePath]];
    self.player = [AVPlayer playerWithPlayerItem:self.playItem];
    
    self.showsPlaybackControls = NO;
}
/**playItem 添加观察者  监控其播放属性更改*/
- (void)addAudioPlayObserver:(AVPlayerItem *)playitem{
    
    [playitem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:
                if (self.button) {
                    [self.backImg removeFromSuperview];
                    self.button.hidden = NO;
                    [self.view bringSubviewToFront:self.button];
                }
                break;
            case AVPlayerStatusFailed:
                break;
            case AVPlayerStatusUnknown:
                break;
            default:
                break;
        }
    }
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
