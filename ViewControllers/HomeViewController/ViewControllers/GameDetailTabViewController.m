//
//  GameDetailTabViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameDetailTabViewController.h"
#import "GameLiveViewController.h"
#import "GameHeaderView.h"
#import "GameSegmentView.h"
#import "GameDataViewController.h"


#define GameHeadHigh    Anno750(480)
#define GameSelectHigh  (64 + Anno750(80))
@interface GameDetailTabViewController ()<GameLiveViewControllerDelegate,GameDataViewControllerDelegate>

@property (nonatomic, strong) GameHeaderView * headView;
@property (nonatomic, strong) GameSegmentView * segementView;
@property (nonatomic, strong) GameBassViewController * currentVC;
@property (nonatomic, strong) NSMutableArray<GameBassViewController *> * viewControllers;

@end

@implementation GameDetailTabViewController

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
    [self setNavAlpha];
    [self drawBackButton];
    [self setNavTitle:@"比赛详情"];
    [self creatUI];
}
- (void)creatUI{
    self.viewControllers = [NSMutableArray new];
    
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, GameHeadHigh - GameSelectHigh);
    
    GameLiveViewController * live = [[GameLiveViewController alloc]init];
    live.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT );
    [self addChildViewController:live];
    live.delegate = self;
    live.tabview.tableHeaderView = header;
    [self.view addSubview:live.view];
    self.currentVC = live;
    [self.viewControllers addObject:live];
    
    GameDataViewController * data = [[GameDataViewController alloc]init];
    data.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
    [self addChildViewController:data];
    data.tabview.tableHeaderView = header;
    data.delegate = self;
    [self.viewControllers addObject:data];
    
    
    self.segementView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, GameSelectHigh)];
    [self.view addSubview:self.segementView];
    
    self.headView = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, GameHeadHigh)];
    [self.view addSubview:self.headView];
    
    __weak GameDetailTabViewController * weakself = self;
    [self.headView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.segementView.segmentView setSelectedSegmentIndex:index];
    }];
    [self.segementView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.headView.segmentView setSelectedSegmentIndex:index];
    }];
}
#pragma mark - 切换viewController
- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    /**
     *  切换ViewController
     */
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //做一些动画
    } completion:^(BOOL finished) {
        
        if (finished) {
            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = (GameBassViewController *)newController;
            [self.view bringSubviewToFront:self.headView];
            [self updateScrollerViewContentOffset];
            
        }else
        {
            self.currentVC = (GameBassViewController *)oldController;
        }
        
    }];
}
- (void)updateScrollerViewContentOffset{
    if (self.headView.hidden) {
        self.currentVC.tabview.contentOffset = CGPointMake(0, GameHeadHigh - GameSelectHigh);
    }else{
        self.currentVC.tabview.contentOffset = CGPointMake(0, 0);
    }
}

- (void)hiddenOutHeadView:(CGFloat)y{
    if (y > GameHeadHigh + Anno750(200)) {
        return;
    }else if(y< 0){
        self.headView.frame = CGRectMake(0, 0, UI_WIDTH, GameHeadHigh);
    }else{
        self.headView.frame = CGRectMake(0, -y, UI_WIDTH, GameHeadHigh);
    }
    self.headView.groundImg.alpha = 1 - y/(GameHeadHigh - GameSelectHigh);
    if (y >= Anno750(270)) {
        self.headView.hidden = YES;
    }else{
        self.headView.hidden = NO;
    }
    
    //动画
    if (y>0) {
        float uas = y/(GameHeadHigh - GameSelectHigh);
        float leftImgx = Anno750(60) + uas*(Anno750(85 * 2) - Anno750(60));
        float imagY = Anno750(160) - (Anno750(160) - 20 - Anno750(4)) * uas;
        float w = Anno750(120) - uas * (Anno750(40));
        float rightImgx = (UI_WIDTH - Anno750(180)) + uas *(Anno750(100) - Anno750(85 *2));
        float leftScoreX = Anno750(240) + uas * (Anno750(85 * 2) - Anno750(120));
        float scoreY = Anno750(210) - (Anno750(210) - 20 - Anno750(12)) * uas;
        float rightScoreX = UI_WIDTH - Anno750(300) - uas * (Anno750(85 * 2 - 120));
        
        self.headView.leftName.alpha = 1 - uas;
        self.headView.rightName.alpha = 1 - uas;
        self.headView.vsLabel.alpha = 1 - uas;
        self.headView.gameStatus.alpha = 1 - uas;
        self.navigationItem.titleView.alpha = 1- uas;
        self.headView.leftImg.frame = CGRectMake(leftImgx, imagY + y, w, w);
        self.headView.rightImg.frame = CGRectMake(rightImgx, imagY+ y, w, w);
        self.headView.leftScore.frame = CGRectMake(leftScoreX, scoreY + y, Anno750(60), Anno750(60));
        self.headView.rightScore.frame = CGRectMake(rightScoreX, scoreY + y, Anno750(60), Anno750(60));
    }
    
}

@end
