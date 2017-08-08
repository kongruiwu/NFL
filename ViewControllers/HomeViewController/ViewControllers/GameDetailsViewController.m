//
//  GameDetailsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameDetailsViewController.h"
#import "GameHeaderView.h"
#import "GameSegmentView.h"
#import "GameLiveViewController.h"
#import "GameDataViewController.h"
#import "SubVideoViewController.h"


#define GameHeadHigh    Anno750(480)
#define GameSelectHigh  (64 + Anno750(80))

typedef NS_ENUM(NSInteger,GameType){
    GameTypePlaying = 0 ,   //比赛正在进行中
    GameTypeOvered      ,   //比赛结束
    GameTypeWaitBegin   ,   //比赛尚未开始
};

@interface GameDetailsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) GameHeaderView * header;
@property (nonatomic, strong) NSMutableArray * viewControllers;
@property (nonatomic, strong) UIViewController * currentVC;
@property (nonatomic, strong) UITableView * currentTab;
@property (nonatomic, strong) UIScrollView * mainScrol;
@property (nonatomic, strong) GameSegmentView * gameSelectView;
@end

@implementation GameDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavAlpha];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavUnAlpha];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"比赛详情"];
    [self setNavAlpha];
    [self creatUI];
}


- (void)creatUI{

    self.mainScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    self.mainScrol.delegate = self;
    [self.view addSubview:self.mainScrol];
    
    self.viewControllers = [NSMutableArray new];
    
    GameLiveViewController * live = [[GameLiveViewController alloc]init];
    [self addChildViewController:live];
    live.view.frame = CGRectMake(0, GameHeadHigh, UI_WIDTH, UI_HEGIHT);
    self.currentVC = live;
    self.currentTab = live.tabview;
    [self.mainScrol addSubview:live.view];
    [self.viewControllers addObject:live];
    
    GameDataViewController * data = [[GameDataViewController alloc]init];
    [self addChildViewController:data];
    data.view.frame = CGRectMake(0, GameHeadHigh, UI_WIDTH, UI_HEGIHT);
    [self.viewControllers addObject:data];
    [self.mainScrol addSubview:data.view];
    
    SubVideoViewController * video = [[SubVideoViewController alloc]init];
    [video setNavAlpha];
    [self addChildViewController:video];
    video.view.frame = CGRectMake(0, GameHeadHigh, UI_WIDTH, UI_HEGIHT);
    [self.viewControllers addObject:video];
    [self.mainScrol addSubview:video.view];

    
    [self updateContetSize:self.currentTab.contentSize];
    
    self.header = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH,GameHeadHigh)];
    __weak GameDetailsViewController * weakself = self;
    [self.header.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.gameSelectView.segmentView setSelectedSegmentIndex:index];
    }];
    
    [self.mainScrol addSubview:self.header];
    
    self.gameSelectView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, GameSelectHigh)];
    self.gameSelectView.alpha = 0;
    [self.gameSelectView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.header.segmentView setSelectedSegmentIndex:index];
    }];
    
    [self.view addSubview:self.gameSelectView];
}
- (void)updateContetSize:(CGSize)size{
    CGSize contentSize = size;
    contentSize.height = contentSize.height + GameHeadHigh;
    self.mainScrol.contentSize = contentSize;
    
    CGRect frame  = self.currentTab.frame;
    frame.size.height = size.height;
    self.currentTab.frame = frame;
}
#pragma mark - 切换viewController
- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    oldController.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
    [self.mainScrol addSubview:oldController.view];
    [self.currentVC.view removeFromSuperview];
    self.currentVC = oldController;
}


//设置头部拉伸效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float y = scrollView.contentOffset.y;
    if (y< 0) {
        CGRect frame = self.header.frame;
        frame.origin.y = y;
        self.header.frame = frame;
        
        frame = self.currentTab.frame;
        frame.origin.y = y;
        self.currentTab.frame = frame;
        
        self.currentTab.contentOffset = CGPointMake(0, y);
    }else{
        if (y <= GameHeadHigh - GameSelectHigh) {
            self.gameSelectView.alpha = 0;
        }else{
            self.gameSelectView.alpha = 1;
        }
        self.header.groundImg.alpha = 1 - y/(GameHeadHigh - GameSelectHigh);
    }
}



@end
