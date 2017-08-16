//
//  ScheduleViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleListCell.h"
#import "MatchListModel.h"
#import "GameDetailTabViewController.h"
@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView * tabview;

@property (nonatomic, strong) NSMutableArray<MatchListModel *> * dataArray;


@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self getData];
    
}
- (void)creatUI{
    self.dataArray =[NSMutableArray new];
    
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 49 - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];

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
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count+1) {
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
    GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithMatchDetailModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getData{
    [self requestDataWithParmas:@{}];
}
- (void)requestDataWithParmas:(NSDictionary *)params{
    
    [SVProgressHUD show];
    
    [self.dataArray removeAllObjects];
    
    [[NetWorkManger manager] sendRequest:PageSchedules route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            MatchListModel * model = [[MatchListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}


@end
