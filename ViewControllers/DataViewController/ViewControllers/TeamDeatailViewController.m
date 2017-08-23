//
//  TeamDeatailViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDeatailViewController.h"
#import "TeamDetailHeader.h"
#import "SelectTopView.h"
#import "TeamDataViewController.h"
#import "TeamMatchViewController.h"
#import "TeamersViewController.h"
#import "TeamNewsViewController.h"
#import "TeamDataModel.h"
#import "LoginViewController.h"
#define TeamHeaderHigh  Anno750(148 *2)

@interface TeamDeatailViewController ()<GameBassDelegate>

@property (nonatomic, strong) UIBarButtonItem * baritem;
@property (nonatomic, strong) TeamDetailHeader * teamHeader;
@property (nonatomic, strong) SelectTopView * selectView;
@property (nonatomic, strong) GameBassViewController * currentVC;
@property (nonatomic, strong) NSMutableArray<GameBassViewController *> * viewControllers;
@property (nonatomic, strong) TeamDataModel * teamModel;

@end

@implementation TeamDeatailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self setNavLineHidden];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setRightBarItem];
    [self creatUI];
    [self getData];

}
- (void)setRightBarItem{
    UIImage * image=  [[UIImage imageNamed:@"nav_icon_collection_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.baritem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(collectionThiesTeam:)];
    self.navigationItem.rightBarButtonItem = self.baritem;
}
- (void)collectionThiesTeam:(UIBarButtonItem *)baritem{
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"team_id":self.teamModel.team_id
                              };
    [[NetWorkManger manager] sendRequest:PageFollowTeam route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"关注成功";
        if (self.teamModel.followed) {
            title = @"取消关注成功";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        self.teamModel.followed = !self.teamModel.followed;
        if (self.teamModel.followed) {
            HomeTeam * model = [[HomeTeam alloc]init];
            model.team_id = self.teamModel.team_id;
            model.team_name = self.teamModel.name;
            [[UserManager manager].info.follow_teams addObject:model];
        }else{
            for (int i = 0; i<[UserManager manager].info.follow_teams.count; i++) {
                HomeTeam * team = [UserManager manager].info.follow_teams[i];
                if ([team.team_id integerValue] == [self.teamModel.team_id integerValue]) {
                    [[UserManager manager].info.follow_teams removeObject:team];
                    break;
                }
            }
        }
        [self updateRightBarItem];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
    
}
- (void)updateRightBarItem{
    NSString * imageName = self.teamModel.followed ? @"nav_icon_collection_hig" : @"nav_icon_collection_normal";
    UIImage * image=  [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.baritem setImage:image];
}
- (void)creatUI{
    self.viewControllers = [NSMutableArray new];
    
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, TeamHeaderHigh);
    
    TeamDataViewController * data = [[TeamDataViewController alloc]init];
    data.view.frame = CGRectMake(0, Anno750(80), UI_WIDTH, UI_HEGIHT );
    [self addChildViewController:data];
    data.delegate = self;
    data.tabview.tableHeaderView = header;
    [self.view addSubview:data.view];
    self.currentVC = data;
    [self.viewControllers addObject:data];
    
    
    TeamMatchViewController * match = [[TeamMatchViewController alloc]init];
    match.teamID = self.teamID;
    match.view.frame = CGRectMake(0, Anno750(80), UI_WIDTH, UI_HEGIHT );
    [self addChildViewController:match];
    match.delegate = self;
    match.tabview.tableHeaderView = header;
    [self.viewControllers addObject:match];
    
    TeamersViewController * teamer = [[TeamersViewController alloc]init];
    teamer.teamID = self.teamID;
    teamer.view.frame = CGRectMake(0, Anno750(80), UI_WIDTH, UI_HEGIHT );
    [self addChildViewController:teamer];
    teamer.delegate = self;
    teamer.tabview.tableHeaderView = header;
    [self.viewControllers addObject:teamer];
    
    TeamNewsViewController * news = [[TeamNewsViewController alloc]init];
    news.teamID = self.teamID;
    news.view.frame = CGRectMake(0, Anno750(80), UI_WIDTH, UI_HEGIHT );
    [self addChildViewController:news];
    news.delegate = self;
    news.tabview.tableHeaderView = header;
    [self.viewControllers addObject:news];
    
    self.teamHeader = [[TeamDetailHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, TeamHeaderHigh + Anno750(80))];
    self.selectView = [[SelectTopView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80)) andTitles:@[@"数据",@"赛程",@"球员",@"资讯"]];
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.teamHeader];
    
    
    __weak TeamDeatailViewController * weakself = self;
    [self.selectView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.teamHeader.selectView.segmentView setSelectedSegmentIndex:index];
    }];
    [self.teamHeader.selectView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.selectView.segmentView setSelectedSegmentIndex:index];
    }];
}
#pragma mark - 切换viewController
- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];

    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //做一些动画
    } completion:^(BOOL finished) {
        
        if (finished) {
            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = (GameBassViewController *)newController;
            [self updateScrollerViewContentOffset];
            [self.view bringSubviewToFront:self.teamHeader];
            
        }else
        {
            self.currentVC = (GameBassViewController *)oldController;
        }
        
    }];
}
- (void)updateScrollerViewContentOffset{
    if (self.teamHeader.hidden) {
        self.currentVC.tabview.contentOffset = CGPointMake(0, TeamHeaderHigh);
    }else{
        self.currentVC.tabview.contentOffset = CGPointMake(0, 0);
    }
}

- (void)hiddenOutHeadView:(CGFloat)y{
    if (y>TeamHeaderHigh + Anno750(200)) {
        return;
    }else if (y < 0) {
        self.teamHeader.frame = CGRectMake(0, 0, UI_WIDTH, TeamHeaderHigh + Anno750(80));
    }else{
        self.teamHeader.frame = CGRectMake(0, -y, UI_WIDTH, TeamHeaderHigh + Anno750(80));
    }
    if (y >= Anno750(148 * 2)) {
        self.teamHeader.hidden = YES;
    }else{
        self.teamHeader.hidden = NO;
    }
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"team_id":self.teamID,
                              @"page":@"data",
                              @"uid":[UserManager manager].isLogin ? [UserManager manager].userID : @""
                              };
    [[NetWorkManger manager] sendRequest:TeamDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.teamModel = [[TeamDataModel alloc]initWithDictionary:dic];
        [self.teamHeader updateWithTeamDataModel:self.teamModel];
        [self setNavTitle:self.teamModel.name];
        if ([self.currentVC isKindOfClass:[TeamDataViewController class]]) {
            TeamDataViewController * vc = (TeamDataViewController *)self.currentVC;
            vc.dataInfo = self.teamModel.data_info;
        }
        [self updateRightBarItem];
    } error:^(NFError *byerror) {
        
    }];
}


@end
