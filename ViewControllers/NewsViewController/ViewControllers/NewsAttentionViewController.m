//
//  NewsAttentionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NewsAttentionViewController.h"
#import "AddAttentionViewController.h"
#import "NullTeamView.h"
#import "AttentionTeamHeader.h"
#import "NewsAttenListCell.h"
#import "LoginViewController.h"
#import "WKWebViewController.h"
@interface NewsAttentionViewController ()<UITableViewDelegate,UITableViewDataSource,NewsAttenListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NullTeamView * nullteamView;
@property (nonatomic, strong) AttentionTeamHeader * teamHeader;
@property (nonatomic, strong) NSMutableArray<InfoListModel *> * dataArray;
@end

@implementation NewsAttentionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserManager manager].isLogin || [UserManager manager].info.follow_teams.count == 0) {
        self.nullteamView.hidden = NO;
        [self.view bringSubviewToFront:self.nullteamView];
        self.teamHeader.dataArray = @[];
    }else{
        self.nullteamView.hidden = YES;
        [self refreshData];
        self.teamHeader.dataArray = [UserManager manager].info.follow_teams;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creatUI];
}
- (void)creatUI{
    
    self.dataArray = [NSMutableArray new];
    
    self.nullteamView = [[NullTeamView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80))];
    self.nullteamView.hidden = YES;
    [self.nullteamView.chooseBtn addTarget:self action:@selector(addAttentionTeam) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nullteamView];
    
    self.teamHeader = [[AttentionTeamHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(120))];
    [self.teamHeader.addBtn addTarget:self action:@selector(pushToSelectTeamViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teamHeader];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, UI_HEGIHT - Anno750(320) - 49) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(275 * 2);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"NewsAttenListCell";
    NewsAttenListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NewsAttenListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithObjectModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"资讯" url:self.dataArray[indexPath.section].app_iframe];
    vc.infoModel = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushToSelectTeamViewController{
    [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
}
- (void)addAttentionTeam{
    if ([UserManager manager].isLogin) {
        [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
    }else{
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"你还没有登录，请先登录" duration:2.0f];
        LoginViewController * vc = [[LoginViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}

- (void)getData{
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"last_id":self.dataArray.count == 0 ? @"" : self.dataArray.lastObject.id
                              };
    [[NetWorkManger manager] sendRequest:PageFollowNews route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * data = result[@"data"];
        NSArray * arr = data[@"list"];
        for (int i = 0; i<arr.count; i++) {
            InfoListModel * model = [[InfoListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        NSArray * teams = data[@"follow_teams"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<teams.count; i++) {
            HomeTeam * model = [[HomeTeam alloc]initWithDictionary:teams[i]];
            [muarr addObject:model];
        }
        [UserManager manager].info.follow_teams = [NSMutableArray arrayWithArray:muarr];
        if (arr.count == 0 && self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
        if (arr.count< 5) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        [self.refreshHeader endRefreshing];
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}
- (void)collectThisCellItem:(UIButton *)btn{
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    UITableViewCell * cell = (UITableViewCell *)[btn superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    InfoListModel * model = self.dataArray[indexpath.section];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":model.cont_type,
                              @"id":model.id
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        if (model.collected) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        model.collected = !model.collected;
        if (model.collected) {
            model.collect_num = @(model.collect_num.intValue + 1);
        }else{
            model.collect_num = @(model.collect_num.intValue - 1);
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

@end
