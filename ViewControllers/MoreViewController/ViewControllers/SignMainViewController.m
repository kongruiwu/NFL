//
//  SignMainViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SignMainViewController.h"
#import "MissonListTableViewCell.h"
#import "SignInMainHeader.h"
#import "PrizesViewController.h"
#import "SignInViewController.h"
#import "ScoreRankViewController.h"
#import "AttionThirdView.h"
#import "WKWebViewController.h"
#import "UserInfoViewController.h"
#import "TeamInfoViewController.h"

@interface SignMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * missons;
@property (nonatomic, strong) NSArray * todayMissons;
@property (nonatomic, strong) SignInMainHeader * header;
//是否是新手任务
@property (nonatomic, assign) BOOL isPlayer ;
@property (nonatomic, strong) AttionThirdView * thirdBindView;

@end

@implementation SignMainViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self setNavLineHidden];
    [self getScoreData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needBackToCompleteMisson) name:NotificationMissonBack object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self creatUI];
}

- (void)creatUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isPlayer = NO;
    //(微博、微信、QQ 登陆)
    self.missons = @[@"更换头像",@"使用第三方帐号",@"关注NFL橄榄球官方微博",@"关注NFL橄榄球官方微信",@"选择主队"];
    self.todayMissons = @[@"签到",@"评论",@"分享",@"收藏"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.header = [[SignInMainHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(535))];
    [self.header.prizeBtn addTarget:self action:@selector(checkPrizeViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.header.todayMisson addTarget:self action:@selector(changeMisssonType:) forControlEvents:UIControlEventTouchUpInside];
    [self.header.playerMisson addTarget:self action:@selector(changeMisssonType:) forControlEvents:UIControlEventTouchUpInside];
    [self.header.rankBtn addTarget:self action:@selector(checkScoreRankController) forControlEvents:UIControlEventTouchUpInside];
    self.tabview.tableHeaderView = self.header;
    
    self.thirdBindView = [[AttionThirdView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    [self.thirdBindView.sureBtn addTarget:self action:@selector(checkThirdCodeReuqest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.thirdBindView];
    
}

- (void)getScoreData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              };
    [[NetWorkManger manager] sendRequest:ScoreInfo route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        [UserManager manager].score = [[ScoreRankModel alloc]initWithDictionary:result[@"data"]];
        [self.header updateWithScoreRankModel:[UserManager manager].score isDaily:!self.isPlayer];
        [self.tabview reloadData];
        [SVProgressHUD dismiss];
    } error:^(NFError *byerror) {
        [SVProgressHUD dismiss];
    }];
}

- (void)checkPrizeViewController{
    [self.navigationController pushViewController:[PrizesViewController new] animated:YES];
}
- (void)checkScoreRankController{
    [self.navigationController pushViewController:[ScoreRankViewController new] animated:YES];
}
- (void)changeMisssonType:(UIButton *)btn{
    if (btn == self.header.todayMisson) {
        if (self.isPlayer) {
            self.isPlayer = NO;
            [[UserManager manager].score updateTaskOverCount];
            [self.header updateWithScoreRankModel:[UserManager manager].score isDaily:!self.isPlayer];
            [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        }
    }else{
        if (!self.isPlayer) {
            self.isPlayer = YES;
            [[UserManager manager].score updateTaskOverCount];
            [self.header updateWithScoreRankModel:[UserManager manager].score isDaily:!self.isPlayer];
            [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ScoreRankModel * model = [UserManager manager].score;
    return self.isPlayer ? model.newbie.count : model.daily.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [Factory creatViewWithColor:[UIColor whiteColor]];
    headView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UILabel * label = [Factory creatLabelWithText:self.isPlayer ? @"新手任务":@"今日任务"
                                        fontValue:font750(32)
                                        textColor:Color_LightBlue
                                    textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:font750(32)];
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * foot = [Factory creatViewWithColor:[UIColor whiteColor]];
    foot.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UIButton * btn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    UILabel * label = [Factory creatLabelWithText:@"积分规则及兑换说明 >"
                                        fontValue:font750(26)
                                        textColor:Color_Line
                                    textAlignment:NSTextAlignmentCenter];
    [btn addTarget:self action:@selector(checkScoreRules) forControlEvents:UIControlEventTouchUpInside];
    [foot addSubview:label];
    [foot addSubview:btn];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.centerX.equalTo(@0);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    return foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"MissonListTableViewCell";
    MissonListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MissonListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    ScoreRankModel * model = [UserManager manager].score;
    [cell updateWithMissonModel:self.isPlayer ? model.newbie[indexPath.row] : model.daily[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MissonModel * model;
    if (self.isPlayer) {
        model = [UserManager manager].score.newbie[indexPath.row];
    }else{
        model = [UserManager manager].score.daily[indexPath.row];
    }
    if (model.completed) {
        return;
    }
    if ([model.title containsString:@"签到"]) {
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[SignInViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }else if([model.title containsString:@"评论"]){
        [self needBackToCompleteMisson];
    }else if([model.title containsString:@"分享"]){
        [self needBackToCompleteMisson];
    }else if([model.title containsString:@"收藏"]){
        [self needBackToCompleteMisson];
    }else if([model.title containsString:@"更换头像"]){
        [self.navigationController pushViewController:[UserInfoViewController new] animated:YES];
    }else if([model.title containsString:@"第三方"]){
        UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"使用第三方软件快速登录，或者登录后绑定第三方软件信息即可完成任务。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        [alertControl addAction:sure];
        [self presentViewController:alertControl animated:YES completion:nil];
    }else if([model.title containsString:@"微博"]){
        self.thirdBindView.thirdType = ThirdTypeSina;
        [self.thirdBindView show];
    }else if([model.title containsString:@"微信"]){
        self.thirdBindView.thirdType = ThirdTypeWexin;
        [self.thirdBindView show];
    }else if([model.title containsString:@"主队"]){
        TeamInfoViewController * vc = [[TeamInfoViewController alloc]init];
        vc.isSet = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)needBackToCompleteMisson{
    [self.tabBarController setSelectedIndex:1];
    [self.navigationController popToRootViewControllerAnimated:NO];
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
        self.header.bgImg.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}

- (void)checkScoreRules{
    WKWebViewController * wk = [[WKWebViewController alloc]initWithTitle:@"积分规则" url:@"http://www.nflchina.com/expaward/rules"];
    [self.navigationController pushViewController:wk animated:YES];
}
- (void)checkThirdCodeReuqest{
    NSDictionary * params = @{
                              @"uid":[UserManager manager].info.uid,
                              @"task":self.thirdBindView.thirdType == ThirdTypeSina ? @"weibo_follow":@"wechat_follow",
                              @"code":self.thirdBindView.codeView.textField.text
                              };
    [[NetWorkManger manager] sendRequest:Page_ThirdTask route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"关注成功，任务完成" duration:2.0f];
        [self.thirdBindView dismiss];
        [self getScoreData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:2.0f];
    }];
}

@end
