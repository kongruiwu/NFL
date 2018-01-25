//
//  AttentionteamViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AttentionteamViewController.h"
#import "NullTeamView.h"
#import "AttentionTeamHeader.h"
#import "ScheduleListCell.h"
#import "AddAttentionViewController.h"
#import "LoginViewController.h"
#import "GameDetailTabViewController.h"
#import "MatchListModel.h"
#import "HomeInfoModel.h"
@interface AttentionteamViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NullTeamView * nullteamView;
@property (nonatomic, strong) AttentionTeamHeader * teamHeader;

@property (nonatomic, strong) NSMutableArray<MatchListModel *> * dataArray;
@property (nonatomic, strong) HomeInfoModel * requestInfo;
//当加载更多上周数据时  上周参数
@property (nonatomic, strong) InfoParams * preInfo;
//当加载更多下周数据时  下周参数
@property (nonatomic, strong) InfoParams * nextInfo;

@end

@implementation AttentionteamViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserManager manager].isLogin || [UserManager manager].info.follow_teams.count == 0) {
        self.nullteamView.hidden = NO;
        [self.view bringSubviewToFront:self.nullteamView];
        self.teamHeader.dataArray = @[];
    }else{
        self.nullteamView.hidden = YES;
        [self getData];
        self.teamHeader.dataArray = [UserManager manager].info.follow_teams;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, UI_HEGIHT - Anno750(320) - 49) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUpWeekData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextWeekData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray[section].list.count + 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view = [Factory creatViewWithColor:Color_BackGround];
    view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UIButton * button = [Factory creatButtonWithTitle:@""
                                      backGroundColor:[UIColor clearColor]
                                            textColor:Color_LightGray
                                             textSize:font750(26)];
    NSString * title = [NSString stringWithFormat:@"  %@  %@",self.dataArray[section].c_date,self.dataArray[section].c_date_w];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"sidebar_icon_calendar_default"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count+1) {
        return Anno750(20);
    }
    return Anno750(220);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ||indexPath.row == self.dataArray[indexPath.section].list.count+1) {
        static NSString * cellid = @"grayCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.backgroundColor = Color_BackGround2;
        return cell;
    }
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithMatchDetailModel:self.dataArray[indexPath.section].list[indexPath.row -1]];
    cell.line.hidden = indexPath.row == 1 ? YES : NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count + 1) {
        return;
    }
    MatchDetailModel * model = self.dataArray[indexPath.section].list[indexPath.row - 1];
    GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithGameID:model.gameId matchStatus:model.match_state.integerValue];
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


- (void)getData{
    [self requestDataWithParmas:@{@"follow_team_uid":[UserManager manager].userID}];
}
- (void)requestDataWithParmas:(NSDictionary *)params{
    [self requestDataWithParmas:params isRefresh:NO isUp:NO];
}

- (void)requestDataWithParmas:(NSDictionary *)params isRefresh:(BOOL)rec isUp:(BOOL)isUp{
    [SVProgressHUD show];
    
    [[NetWorkManger manager] sendRequest:PageSchedules route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        NSDictionary * dic = result[@"info"];
        self.requestInfo = [[HomeInfoModel alloc]initWithDictionary:dic];
        //更新参数
        if (!rec) {
            self.preInfo = self.requestInfo.pre;
            self.nextInfo = self.requestInfo.next;
        }
        //刷新数据 需要置空dataArray 不能提前释放
        if (!rec && !isUp) {
            [self.dataArray removeAllObjects];
        }
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            MatchListModel * model = [[MatchListModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        if (rec && !isUp) {//当在加载更多   且属于 下拉时
            [muarr addObjectsFromArray:self.dataArray];
            self.dataArray = [NSMutableArray arrayWithArray:muarr];
        }else{
            [self.dataArray addObjectsFromArray:muarr];
        }
        
        if (rec) {
            if (isUp) {
                self.nextInfo = self.requestInfo.next;
            }else{
                self.preInfo = self.requestInfo.pre;
            }
        }
        [self.tabview reloadData];
        [self.refreshHeader endRefreshing];
        if (self.requestInfo.next.match_type && self.requestInfo.next.match_type.length>0) {
            [self.refreshFooter endRefreshing];
        }else{
            if (isUp) {
                [self.refreshFooter endRefreshingWithNoMoreData];
            }else{
                [self.refreshFooter endRefreshing];
            }
            
        }
    } error:^(NFError *byerror) {
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}

- (void)loadUpWeekData{
    if (self.preInfo.match_type && self.preInfo.match_type.length>0) {
        NSDictionary * params = @{
                                  @"type":self.preInfo.match_type,
                                  @"week":self.preInfo.week,
                                  @"follow_team_uid":[UserManager manager].userID
                                  };
        [self requestDataWithParmas:params isRefresh:YES isUp:NO];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"已经是最早赛程了" duration:1.0f];
        [self.refreshHeader endRefreshing];
    }
}
- (void)loadNextWeekData{
    if (!self.nextInfo.match_type) {
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"暂无比赛信息" duration:1.0];
        return ;
    }
    NSDictionary * params = @{
                              @"type":self.nextInfo.match_type,
                              @"week":self.nextInfo.week,
                              @"follow_team_uid":[UserManager manager].userID
                              };
    [self requestDataWithParmas:params isRefresh:YES isUp:YES];
}

@end
