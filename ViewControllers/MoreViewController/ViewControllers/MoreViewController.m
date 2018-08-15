//
//  MoreViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreHeadView.h"
#import "MoreListCell.h"
#import "UserInfoViewController.h"
#import "OnlineQuestionViewController.h"
#import "FeedBackViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "MyCollectionViewController.h"
#import "AddAttentionViewController.h"
#import "WKWebViewController.h"
#import "TeachViewController.h"
#import "SignMainViewController.h"
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) MoreHeadView * header;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UIImageView * adFoot;
@property (nonatomic, strong) NSNumber * messageCount;

@end

@implementation MoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self setNavAlpha];
    [self.header updateUIbyUserInfo];
    [self.tabview reloadData];
    [MobClick event:Mob_More];
    [self requestMessageCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    self.messageCount = @0;
    self.images = @[@[@"list_icon_follow",@"mine_sign",@"list_icon_collection"],@[@"list_icon_q&a",@"list_icon_101class",@"list_icon_daydaynfl"],@[@"list_icon_feedback",@"list_icon_about",@"list_icon_set"]];
    self.titles = @[@[@"我的关注",@"每日签到",@"我的收藏"],@[@"在线问答",@"101课堂",@"天天NFL"],@[@"意见反馈",@"关于我们",@"设置"]];
    float h = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 11) {
        h = - Nav64;
    }
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, h, UI_WIDTH, UI_HEGIHT + Nav64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.header = [[MoreHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(260))];
    [self.header.clearButton addTarget:self action:@selector(userInfoSetting) forControlEvents:UIControlEventTouchUpInside];
    self.tabview.tableHeaderView = self.header;
    
    self.adFoot = [Factory creatImageViewWithImage:@""];
    self.adFoot.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(100));
    self.tabview.tableFooterView = self.adFoot;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.titles[section];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"MoreListCell";
    MoreListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [cell updateWithTitle:self.titles[indexPath.section][indexPath.row] image:self.images[indexPath.section][indexPath.row] desc:[NSString stringWithFormat:@"%@",self.messageCount]];
    }else{
        [cell updateWithTitle:self.titles[indexPath.section][indexPath.row] image:self.images[indexPath.section][indexPath.row] desc:@""];
    }
    return cell;
}

//设置头部拉伸效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
    self.header.bgImage.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}
- (void)userInfoSetting{
    if ([UserManager manager].isLogin) {
        [self.navigationController pushViewController:[UserInfoViewController new] animated:YES];
    }else{
        [self presentLoginView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (![UserManager manager].isLogin) {
                [self presentLoginView];
                return;
            }
            [self.navigationController pushViewController:[OnlineQuestionViewController new] animated:YES];
        }else if(indexPath.row == 2){
            if (![UserManager manager].isLogin) {
                [self presentLoginView];
                return;
            }
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"天天NFL" url:[UserManager manager].info.ttnfl_game_link];
            [MobClick event:Mob_TTnfl];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row == 1){
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"101课堂" url:Teach_101];
            [MobClick event:Mob_Ball101];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[FeedBackViewController new] animated:YES];
        }else if(indexPath.row == 2){
            [self.navigationController pushViewController:[SettingViewController new] animated:YES];
        }else if(indexPath.row == 1){
            [self.navigationController pushViewController:[AboutUsViewController new] animated:YES];
        }
    }else if(indexPath.section == 0){
        if (![UserManager manager].isLogin) {
            [self presentLoginView];
            return;
        }
        if (indexPath.row == 2) {
            [MobClick event:Mob_MyFavorties];
            [self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
        }else if(indexPath.row == 0){
            [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
        }else if(indexPath.row == 1){
            [self.navigationController pushViewController:[SignMainViewController new] animated:YES];
        }
    }
}
- (void)presentLoginView{
    LoginViewController * vc = [[LoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)requestMessageCount{
    if (![UserManager manager].isLogin) {
        return;
    }
    NSDictionary * params = @{
                             @"uid":[UserManager manager].userID
                             };
    [[NetWorkManger manager] sendRequest:PageMessage route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSDictionary * data = result[@"data"];
        self.messageCount = data[@"online_answer"];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}
@end
