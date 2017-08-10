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
@interface AttentionteamViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NullTeamView * nullteamView;
@property (nonatomic, strong) AttentionTeamHeader * teamHeader;

@end

@implementation AttentionteamViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserManager manager].isLogin) {
        self.nullteamView.hidden = NO;
        [self.view bringSubviewToFront:self.nullteamView];
    }else{
        self.nullteamView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    self.nullteamView = [[NullTeamView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80))];
    self.nullteamView.hidden = YES;
    [self.nullteamView.chooseBtn addTarget:self action:@selector(addAttentionTeam) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nullteamView];
    
    self.teamHeader = [[AttentionTeamHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(120))];
    [self.teamHeader.addBtn addTarget:self action:@selector(pushToSelectTeamViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teamHeader];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, UI_HEGIHT - Anno750(320) - 49) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [Factory creatViewWithColor:Color_BackGround];
    view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UIButton * button = [Factory creatButtonWithTitle:@"  08/05  周六"
                                      backGroundColor:[UIColor clearColor]
                                            textColor:Color_LightGray
                                             textSize:font750(26)];
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
    return Anno750(220);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)pushToSelectTeamViewController{
    [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
}
- (void)addAttentionTeam{
    if ([UserManager manager].isLogin) {
        
    }else{
        LoginViewController * vc = [[LoginViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
