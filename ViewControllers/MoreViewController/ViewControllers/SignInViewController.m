//
//  SignInViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInHeader.h"
#import "SignInTableViewCell.h"




@interface SignInViewController ()<UITableViewDelegate,UITableViewDataSource,SignInTableViewCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) SignInHeader * header;

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;
//是否是因为任务退出本界面
@property (nonatomic, assign) BOOL isMissonBack;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavAlpha];
    [self creatUI];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.isMissonBack) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMissonBack object:nil];
    }
}

- (void)drawBackButton{
    self.backType = SelectorBackTypeDismiss;
    UIImage * image = [[UIImage imageNamed:@"score_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)creatUI{
    
    UIImageView * image = [Factory creatImageViewWithImage:@"score_bg"];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
    
    self.titles = @[@"评论",@"分享",@"收藏"];
    self.images = @[@"score_comment",@"score_share",@"score_collect"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    self.tabview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tabview];
    
    self.header = [[SignInHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(550))];
    [self.header.signIBtn addTarget:self action:@selector(userSignIn) forControlEvents:UIControlEventTouchUpInside];
    [self.header updateScore];
    self.tabview.tableHeaderView = self.header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview = [Factory creatViewWithColor:[UIColor clearColor]];
    headview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UILabel * label = [Factory creatLabelWithText:@"今日任务"
                                        fontValue:font750(32)
                                        textColor:Color_DarkBlue
                                    textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:font750(34)];
    [headview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
    }];
    return headview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(80);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"SignInTableViewCell";
    SignInTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SignInTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithTitle:self.titles[indexPath.row] image:self.images[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SignInTableViewCell * cell = [self.tabview cellForRowAtIndexPath:indexPath];
    if (cell.missonBtn.enabled) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.isMissonBack = YES;
    }
}
- (void)completeTaskClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.isMissonBack = YES;
}


- (void)userSignIn{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].info.uid,
                              @"task":[UserManager manager].score.signInTask.code
                              };
    [[NetWorkManger manager] sendRequest:Page_CompleteTask route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        NSDictionary * param = @{
                                  @"uid":[UserManager manager].userID,
                                  };
        [[NetWorkManger manager] sendRequest:ScoreInfo route:Route_ScoreRank withParams:param complete:^(NSDictionary *result) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"签到成功" duration:2.0f];
            [UserManager manager].score = [[ScoreRankModel alloc]initWithDictionary:result[@"data"]];
            [self.header updateScore];
            [SVProgressHUD dismiss];
        } error:^(NFError *byerror) {
            [SVProgressHUD dismiss];
        }];
    } error:^(NFError *byerror) {
        [SVProgressHUD dismiss];
    }];
}


@end
