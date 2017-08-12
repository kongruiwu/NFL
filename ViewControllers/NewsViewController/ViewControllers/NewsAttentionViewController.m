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
@interface NewsAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NullTeamView * nullteamView;
@property (nonatomic, strong) AttentionTeamHeader * teamHeader;

@end

@implementation NewsAttentionViewController

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
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, UI_HEGIHT - Anno750(320) - 49) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
    return cell;
}

- (void)pushToSelectTeamViewController{
    [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
}
- (void)addAttentionTeam{
//    if ([UserManager manager].isLogin) {
        [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
//    }else{
//        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"你还没有登录，请先登录" duration:2.0f];
//        LoginViewController * vc = [[LoginViewController alloc]init];
//        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
//    }
}
@end
