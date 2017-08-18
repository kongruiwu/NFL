//
//  AddAttentionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AddAttentionViewController.h"
#import "AddTeamCell.h"
#import "FollowedTeamCell.h"
@interface AddAttentionViewController ()<UITableViewDataSource,UITableViewDelegate,AddTeamCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UILabel * header;
@property (nonatomic, strong) NSMutableArray<TeamModel *> * dataArray;


@end

@implementation AddAttentionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"添加关注"];
    [self drawBackButton];
    [self creatUI];
    [self getData];
    
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.header = [Factory creatLabelWithText:[NSString stringWithFormat:@"我的关注(%ld)",[UserManager manager].info.follow_teams.count]
                                    fontValue:font750(28)
                                    textColor:Color_MainBlack
                                textAlignment:NSTextAlignmentCenter];
    self.header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    self.tabview.tableHeaderView = self.header;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 :(self.dataArray.count%4 == 0 ? self.dataArray.count/4 : self.dataArray.count/4 + 1);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? Anno750(120) : Anno750(210);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.01 : Anno750(20);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * cellid = @"FollowedTeamCell";
        FollowedTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[FollowedTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.dataArray = [UserManager manager].info.follow_teams;
        return cell;
    }
    static NSString * cellid = @"AddTeamCell";
    AddTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AddTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSArray * arr = @[self.dataArray[indexPath.row * 4],[self checkTeamModel:(indexPath.row * 4 + 1)],[self checkTeamModel:(indexPath.row * 4  + 2)],[self checkTeamModel:(indexPath.row * 4 + 3)]];
    [cell updateWithArray:arr NeedSelect:YES];
    cell.delegate = self;
    return cell;
}
- (void)selectTeamAtIndex:(NSInteger)index Button:(UIButton *)btn{
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    NSInteger path = indexpath.row * 4 + index;
    [self followTeamRequest:self.dataArray[path].team_id withPath:path];
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

- (void)followTeamRequest:(NSNumber *)teamID withPath:(NSInteger)path{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"team_id":teamID
                              };
    [[NetWorkManger manager] sendRequest:PageFollowTeam route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"关注成功";
        if (self.dataArray[path].followed) {
            title = @"取消关注成功";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        self.dataArray[path].followed = !self.dataArray[path].followed;
        if (self.dataArray[path].followed) {
            HomeTeam * model = [[HomeTeam alloc]init];
            model.team_id = self.dataArray[path].team_id;
            model.team_name = self.dataArray[path].name;
            [[UserManager manager].info.follow_teams addObject:model];
        }else{
            for (int i = 0; i<[UserManager manager].info.follow_teams.count; i++) {
                HomeTeam * team = [UserManager manager].info.follow_teams[i];
                if ([team.team_id integerValue] == [self.dataArray[path].team_id integerValue]) {
                    [[UserManager manager].info.follow_teams removeObject:team];
                    break;
                }
            }
        }
        self.header.text = [NSString stringWithFormat:@"我的关注(%ld)",[UserManager manager].info.follow_teams.count];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
@end
