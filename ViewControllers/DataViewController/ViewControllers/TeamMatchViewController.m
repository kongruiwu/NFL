//
//  TeamMatchViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamMatchViewController.h"
#import "ScheduleListCell.h"
#import "MatchDetailModel.h"
#import "GameDetailTabViewController.h"
@interface TeamMatchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<MatchDetailModel *> * dataArray;

@end

@implementation TeamMatchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(220);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(60);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [Factory creatLabelWithText:[NSString stringWithFormat:@"%@  %@",self.dataArray[section].c_date,self.dataArray[section].c_date_w]
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    label.backgroundColor = Color_BackGround;
    label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    return label;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithMatchDetailModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithMatchDetailModel:self.dataArray[indexPath.section]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"team_id":self.teamID,
                              @"page":@"schedules"
                              };
    [[NetWorkManger manager] sendRequest:TeamDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        if (self.tabview) {
            NSDictionary * dic = result[@"data"];
            NSArray * list = dic[@"schedules"];
            for (int i = 0; i<list.count; i++) {
                MatchDetailModel * model = [[MatchDetailModel alloc]initWithDictionary:list[i]];
                [self.dataArray addObject:model];
            }
            [self.tabview reloadData];
        }
    } error:^(NFError *byerror) {
        
    }];
}

@end
