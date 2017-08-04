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
typedef NS_ENUM(NSInteger,GameType){
    GameTypePlaying = 0 ,   //比赛正在进行中
    GameTypeOvered      ,   //比赛结束
    GameTypeWaitBegin   ,   //比赛尚未开始
};

@interface GameDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GameHeaderView * header;
@property (nonatomic, strong) GameSegmentView * segmentView;
@property (nonatomic, strong) NSMutableArray * viewControllers;
@property (nonatomic, strong) UIViewController * currentVC;

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) GameTabview * tabview1;

//@property (nonatomic, strong) UIScrollView * mainScrol;
@end

@implementation GameDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
- (void)creatUI1{
    self.header = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(560))];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.tabview addSubview:self.header];
    
    [self.view addSubview:self.tabview];
    UIView * clearView = [Factory creatViewWithColor:[UIColor clearColor]];
    clearView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(480) - 64);
    self.tabview.tableHeaderView = clearView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80) + 64;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.segmentView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80) + 64)];
    __weak GameDetailsViewController * weakself = self;
    [self.segmentView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
    }];
    return self.segmentView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UI_HEGIHT - Anno750(208);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    GameLiveViewController * live = [[GameLiveViewController alloc]init];
    [self addChildViewController:live];
    live.view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(208));
    live.tabview.isUpStatus = YES;
    self.tabview1 = live.tabview;
    [cell addSubview:live.view];
    return cell;
}


- (void)creatUI{

    self.viewControllers = [NSMutableArray new];
    
    self.header = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(560))];
    self.segmentView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, Anno750(480), UI_WIDTH, Anno750(80))];
    __weak GameDetailsViewController * weakself = self;
    [self.segmentView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
    }];
    [self.header addSubview:self.segmentView];
    [self.view addSubview:self.header];
    
    GameLiveViewController * live = [[GameLiveViewController alloc]init];
    [self addChildViewController:live];
    live.view.frame = CGRectMake(0, Anno750(560), UI_WIDTH, UI_HEGIHT);
    self.currentVC = live;
    [live didMoveToParentViewController:self];
    [self.view addSubview:live.view];
    [self.viewControllers addObject:live];
    
    GameDataViewController * data = [[GameDataViewController alloc]init];
    [self addChildViewController:data];
    data.view.frame = CGRectMake(0, Anno750(560), UI_WIDTH, UI_HEGIHT);
    [self.viewControllers addObject:data];
    
    SubVideoViewController * video = [[SubVideoViewController alloc]init];
    [video setNavAlpha];
    [self addChildViewController:video];
    video.view.frame = CGRectMake(0, Anno750(560), UI_WIDTH, UI_HEGIHT);
    [self.viewControllers addObject:video];
    
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
            self.currentVC = newController;
            
        }else
        {
            self.currentVC = oldController;
        }
    }];
}


//设置头部拉伸效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    scrollView.bounces = (scrollView.contentOffset.y >= 180) ? NO : YES;

    //图片高度
    CGFloat imageHeight = self.header.frame.size.height;
    //图片宽度
    CGFloat imageWidth = UI_WIDTH;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        
        self.header.groundImg.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
    self.header.groundImg.alpha = 1 - (imageOffsetY/(CGFloat)(Anno750(560) - 64 - Anno750(80)))/4;
//    if (scrollView.contentOffset.y >= 176) {
//        self.tabview1.isUpStatus = NO;
//    }else{
//        self.tabview1.isUpStatus = YES;
//    }
    self.segmentView.groundImg.alpha = imageOffsetY/(CGFloat)(Anno750(560) - 64 - Anno750(80));

}



@end
