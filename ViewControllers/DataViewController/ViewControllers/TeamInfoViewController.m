//
//  TeamInfoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamInfoViewController.h"
#import "AddTeamCell.h"
#import "TeamModel.h"
#import "TeamDeatailViewController.h"
#import "ShowMessageView.h"
@interface TeamInfoViewController ()<UITableViewDelegate,UITableViewDataSource,AddTeamCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<TeamModel *> * dataArray;
@property (nonatomic, strong) ShowMessageView * teamView;

@property (nonatomic, strong) NSString * weibouid;

@end

@implementation TeamInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isSet) {
        [self setNavTitle:@"设置主队"];
        [self drawBackButton];
    }
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    
    
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80) - 49 - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    if (self.isSet) {
        self.tabview.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64);
        self.teamView = [[ShowMessageView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) MessageType:MessageTypeTeam];
        [self.teamView.setTeam addTarget:self action:@selector(openTeamWeibo) forControlEvents:UIControlEventTouchUpInside];
        [self.teamView.sureButton addTarget:self action:@selector(changeUserHomeTeamRequest) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.teamView];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count%4 == 0 ? self.dataArray.count/4 : self.dataArray.count/4 + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(210);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"AddTeamCell";
    AddTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AddTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSArray * arr = @[self.dataArray[indexPath.row * 4],[self checkTeamModel:(indexPath.row * 4 + 1)],[self checkTeamModel:(indexPath.row * 4  + 2)],[self checkTeamModel:(indexPath.row * 4 + 3)]];
    [cell updateWithArray:arr];
    cell.delegate = self;
    return cell;
}
- (id)checkTeamModel:(NSInteger)index{
    id obj = self.dataArray[index];
    if ([obj isKindOfClass:[TeamModel class]]) {
        return obj;
    }else{
        return @"";
    }
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{};
    [[NetWorkManger manager] sendRequest:PageTeamList route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSArray * arr = dic[@"list"];
        for (int i = 0; i<arr.count; i++) {
            TeamModel * model = [[TeamModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(NFError * byerror) {
        
    }];
}
- (void)selectTeamAtIndex:(NSInteger)index Button:(UIButton *)btn{
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    NSInteger path = indexpath.row * 4 + index;
    if (self.isSet) {
        HomeTeam * team = [[HomeTeam alloc]init];
        team.team_id = self.dataArray[path].team_id;
        team.team_name = self.dataArray[path].name;
        self.teamView.homeTeam = team;
        self.weibouid = self.dataArray[path].weibo_uid;
        [self.teamView show];
    }else{
        TeamDeatailViewController * vc = [[TeamDeatailViewController alloc]init];
        vc.teamID = self.dataArray[path].team_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 设置主队
- (void)changeUserHomeTeamRequest{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"home_team":self.teamView.homeTeam.team_id
                              };
    [[NetWorkManger manager] sendRequest:PageUpdateUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"修改成功" duration:1.0f];
        [UserManager manager].info.home_team = self.teamView.homeTeam;
        [self doBack];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
#pragma mark - 打开微博
- (void)openTeamWeibo{
    NSString * urlStr = [NSString stringWithFormat:@"sinaweibo://userinfo?uid=%@",self.weibouid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
@end
