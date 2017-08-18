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
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) MoreHeadView * header;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UIImageView * adFoot;

@end

@implementation MoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self setNavAlpha];
    [self.header updateUIbyUserInfo];
    [self.tabview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
    
}
- (void)creatUI{
    self.images = @[@[@"list_icon_follow",@"list_icon_collection"],@[@"list_icon_q&a",@"list_icon_101class",@"list_icon_daydaynfl"],@[@"list_icon_feedback",@"list_icon_about",@"list_icon_set"]];
    self.titles = @[@[@"我的关注",@"我的收藏"],@[@"在线问答",@"101课堂",@"天天NFL"],@[@"意见反馈",@"关于我们",@"设置"]];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"MoreListCell";
    MoreListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithTitle:self.titles[indexPath.section][indexPath.row] image:self.images[indexPath.section][indexPath.row] desc:@""];
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
    if (![UserManager manager].isLogin) {
        [self presentLoginView];
        return;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[OnlineQuestionViewController new] animated:YES];
        }else if(indexPath.row == 2){
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"天天NFL" url:DaydayNFL];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row == 1){
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"101课堂" url:Teach_101];
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
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
        }else if(indexPath.row == 0){
            [self.navigationController pushViewController:[AddAttentionViewController new] animated:YES];
        }
    }
}
- (void)presentLoginView{
    LoginViewController * vc = [[LoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
